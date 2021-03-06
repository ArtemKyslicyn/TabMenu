//
//  RASwipeHandler.swift
//  TabMenu
//
//  Created by Arcilite on 24.02.16.
//  Copyright © 2016 Arcilite. All rights reserved.
//

import UIKit
import QuartzCore

public enum  RAScrollDirection : Int {
  case LeftPreviosPage
  case RightNextPage
  case Other
}

class RAGestureHandler: NSObject,UIGestureRecognizerDelegate{
  private var panRecognizer:UIPanGestureRecognizer!
  private var pageManager:RAContentPageManager!
  init(pageManager:RAContentPageManager){
    super.init()
    self.pageManager = pageManager
    panRecognizer = UIPanGestureRecognizer(target: self, action: "panGestureMoved:")
    panRecognizer.delegate = self
    pageManager.rootViewController.view?.addGestureRecognizer(panRecognizer)
    
    // self.view!.addGestureRecognizer(panRightGestureRecognizer)
   // self.rootViewController = rootViewController
    
  }
  
  func gestureRecognizerShouldBegin(gestureRecognizer: UIGestureRecognizer) -> Bool{
    if gestureRecognizer == panRecognizer {
      let velocity = panRecognizer.velocityInView(panRecognizer.view);
      return fabs(velocity.x) > 2 * fabs(velocity.y);
    } else {
      return true;
    }
  }
  
  func boundsCenter() -> CGPoint{
    let bounds = self.pageManager.rootViewController.view.bounds
    let boundsCenter = CGPointMake(CGRectGetMidX(bounds), CGRectGetMidY(bounds))
    return boundsCenter;
  }
  
  func panGestureMoved(gestureRecognizer:UIPanGestureRecognizer){
    // Elastic paging and bouncing modeled with damping.

    let boundsCenter = self.boundsCenter()
    
    var translation = gestureRecognizer.translationInView(self.pageManager.rootViewController.view)
    var center = self.pageManager.contentViewController.view.center;
    
  if gestureRecognizer.state == .Began {
      
   

  }else if  gestureRecognizer.state == .Changed{
    
    
      if center.x < boundsCenter.x && !pageManager.isNextPageLoaded() {
        // The end. Add some damping.
        translation.x /= 2;
      } else if center.x > boundsCenter.x  && !pageManager.isPreviosPageLoaded() {
        
        translation.x /= 2;
      }
      
      center.x += translation.x;
      
      if (center.x < boundsCenter.x) {
          pageManager.loadNextNotLoadedPage()
        
      } else if (center.x > boundsCenter.x) {
        
         pageManager.loadPreviosNotLoadePage()
       
      }
      
      pageManager.contentViewController.view.center = center
      var previousViewCenter = center;
      if let previousViewController = pageManager.previousViewController{
           previousViewCenter.x = center.x -  previousViewController.view.frame.width
      }
      previousViewCenter.x = center.x

      pageManager.previousViewController?.view.center = previousViewCenter
      var nextViewCenter = center ;
      
      if let nextViewController = pageManager.nextViewController{
        nextViewCenter.x = center.x +  nextViewController.view.frame.width
      }
       nextViewCenter.x = center.x
     // center.x = center.x + (pageManager.previousViewController?.view.frame.width)! ?? CGFloat(0)
      pageManager.nextViewController?.view.center = nextViewCenter
      
      gestureRecognizer.setTranslation(CGPointZero, inView: gestureRecognizer.view)

    


  }else if gestureRecognizer.state == .Ended || gestureRecognizer.state ==  .Cancelled{
    var velocity = gestureRecognizer.velocityInView(self.pageManager.rootViewController.view);
    // Scale velocity down.
    velocity.x /= 20
    velocity.y /= 20
    
    let mathModel = MathModelSwiping(velocity: velocity)
    CATransaction.begin()
    CATransaction.setAnimationDuration(0.4)
      	//[CATransaction setAnimationDuration:kPagingAnimationDuration];
    let direction =  self.loadPageByDirection(mathModel.x_max, velocityx: velocity.x)
    self.restorePagesByDirection(direction,modelSwiping: mathModel)
   
      
    CATransaction.commit()

  }
    
    
    
  }
  
  func loadPageByDirection(x_max:CGFloat,velocityx:CGFloat) -> RAScrollDirection{
    var direction:RAScrollDirection = .Other
   
    //let
    if x_max >= 0.5 || velocityx > 40 {
      self.pageManager.loadNextNotLoadedPage()
      if ( self.pageManager.isNextPageLoaded()) {
        direction = .RightNextPage
      }
      
      
    } else if x_max <= -0.5  || velocityx < -40 {
      self.pageManager.loadPreviosNotLoadePage()
      if (self.pageManager.isPreviosPageLoaded()) {
        direction = .LeftPreviosPage
      }
    }
    return direction
  }
  
  
  func restorePagesByDirection(direction:RAScrollDirection,modelSwiping:MathModelSwiping){
    switch direction{
    case .LeftPreviosPage:
      self.turnToPreviosPage(modelSwiping)
     // self.turnToNextPage(modelSwiping)
      
    case .RightNextPage: 
     // self.turnToPreviosPage(modelSwiping)
      self.turnToNextPage(modelSwiping)
    case .Other:
      self.restorePage(modelSwiping)
      break;
    }
  }
  
  
  func restorePage(modelSwiping:MathModelSwiping){
    // Bounce back to restore current page.
    CATransaction.begin()
    CATransaction.setAnimationDuration(0.4)
    
    
    if modelSwiping.t_max > 0 && modelSwiping.x_max < 0 {
      pageManager.loadNextNotLoadedPage()
      
    } else if modelSwiping.t_max > 0 && modelSwiping.x_max > 0 {
      
      pageManager.loadPreviosNotLoadePage()
      
    }
   
    self.contentViewAnimation(modelSwiping)
    self.turnToPreviosPage(modelSwiping,dumping: false)
    self.turnToNextPage(modelSwiping,dumping: false)
    

    CATransaction.commit()
  }
  
  
  func turnToPreviosPage(modelSwiping:MathModelSwiping,dumping:Bool = true){
    let boundsCenter = self.boundsCenter()
    let newPreviousViewCenter = boundsCenter;
    let pageDistance =  pageManager.rootViewController.view.bounds.size.width;

    let newCenter =  CGPointMake(boundsCenter.x + pageDistance, boundsCenter.y)
//    if let previousViewController =  self.pageManager.previousViewController{
//     modelSwiping.x_0 = previousViewController.view.center.x - newCenter.x ;
//    }
    var isDumping = false
    if dumping{
     isDumping =  modelSwiping.calcIsPreviosDupming()
    }
    
    let animationsArray = modelSwiping.previousPageAnimationsCoordinatesArrayUnderDamping(isDumping, newCenter: newCenter)
    self.pageManager.contentViewController?.view.addSwipeAnimation(self, animationValues: animationsArray)
    
    CATransaction.setDisableActions(true)
    self.pageManager.contentViewController?.view.layer.position = newCenter;
    CATransaction.setDisableActions(false)
    
    let animationsPreviousArray = modelSwiping.previousPageAnimationsCoordinatesArrayUnderDamping(isDumping, newCenter: newPreviousViewCenter)
    self.pageManager.previousViewController?.view.addSwipeAnimation(self, animationValues: animationsPreviousArray)
    
    
    CATransaction.setDisableActions(true)
    self.pageManager.previousViewController?.view.layer.position = newPreviousViewCenter;
    CATransaction.setDisableActions(false)
    //let newPreviousViewCenter = boundsCenter;
    //let newCenter = CGPointMake(newPreviousViewCenter.x , newPreviousViewCenter.y);
  }
  
  
  func turnToNextPage(modelSwiping:MathModelSwiping,dumping:Bool = true){
   
    let boundsCenter = self.boundsCenter()
    let pageDistance =  pageManager.rootViewController.view.bounds.size.width;
    
    let nextViewCenter = boundsCenter
    let newCenter =  CGPointMake(boundsCenter.x - pageDistance, boundsCenter.y)
   
    var isDumping = false
    if dumping{
      isDumping =  modelSwiping.calcIsNextDupming()
    }
  
    let animationsArray = modelSwiping.previousPageAnimationsCoordinatesArrayUnderDamping(isDumping, newCenter: newCenter)
    self.pageManager.contentViewController?.view.addSwipeAnimation(self, animationValues: animationsArray)
    
    CATransaction.setDisableActions(true)
    self.pageManager.contentViewController?.view.layer.position = newCenter;
    CATransaction.setDisableActions(false)
    
    let newPreviousViewCenter = CGPointMake(newCenter.x - pageDistance, newCenter.y);
    
    let previosArray = modelSwiping.previousPageAnimationsCoordinatesArrayUnderDamping(isDumping, newCenter: newCenter)
    self.pageManager.contentViewController?.view.addSwipeAnimation(self, animationValues: previosArray)
    
    CATransaction.setDisableActions(true)
    self.pageManager.contentViewController?.view.layer.position = newCenter;
    CATransaction.setDisableActions(false)
    
    
    
    let animationsNextArray = modelSwiping.previousPageAnimationsCoordinatesArrayUnderDamping(isDumping, newCenter: newCenter)
    self.pageManager.nextViewController?.view.addSwipeAnimation(self, animationValues: animationsNextArray)
    
    CATransaction.setDisableActions(true)
    self.pageManager.nextViewController?.view.layer.position = nextViewCenter;
    CATransaction.setDisableActions(false)
    
    
    let animationsPreviousArray = modelSwiping.previousPageAnimationsCoordinatesArrayUnderDamping(isDumping, newCenter: newPreviousViewCenter)
    self.pageManager.previousViewController?.view.addSwipeAnimation(self, animationValues: animationsPreviousArray)
    
    CATransaction.setDisableActions(true)
    self.pageManager.previousViewController?.view.layer.position = newPreviousViewCenter;
    CATransaction.setDisableActions(false)

  }
  
  func contentViewAnimation(modelSwiping:MathModelSwiping){
    let animationsArray = modelSwiping.previousPageAnimationsCoordinatesArrayUnderDamping(false, newCenter: pageManager.rootViewController.view.center)
    self.pageManager.contentViewController?.view.addSwipeAnimation(self, animationValues: animationsArray)
    
  }
  
  
}

class MathModelSwiping {
  private var velocity:CGPoint!
  let w_0:CGFloat  = 0.7 // natural frequency
  let zeta:CGFloat = 0.8 // damping ratio for under-damping
  var w_d:CGFloat = 0 // damped frequency
  
  var A:CGFloat = 0;
  var B:CGFloat = 0// = velocity.x + w_0 * 0;
  var t_max:CGFloat = 0 //= max(1 / w_0 - A / B, 0);
  var x_max:CGFloat = 0 // = CGFloat(pow(M_E,Double( -w_0 * t_max))) * (A + B * t_max);
  var x_0 :CGFloat = 0
  
  init(let velocity:CGPoint){
    //super.init()
    self.velocity = velocity
    
     w_d = w_0 * sqrt(1 - zeta * zeta);
   
    // A = 0;
    // B = velocity.x + w_0 * 0;
     self.withoutDumping()
     t_max = max(1 / w_0 - A / B, 0);
     x_max = CGFloat(pow(M_E,Double( -w_0 * t_max))) * (A + B * t_max);
    
  
    
  }
  
  func withoutDumping(){
    A = 0
    B = velocity.x + w_0 * x_0

  }
  
  func calcIsPreviosDupming() -> Bool{
    let isDumping = isPreviosDumping()
    
    if isDumping{
       previosUnderDumping()
    }else{
      self.withoutDumping()
    }
    return isDumping
    
    
  }
  
  func calcIsNextDupming() -> Bool{
    let isDumping = isNextDumping()
    if isDumping {
      nextUnderDumping()
    }else{
      self.withoutDumping()
    }
    return isDumping
  }

  func isPreviosDumping() -> Bool{
    let xMaxLimit:CGFloat = 0;
    let  criticalVelocity : CGFloat  = w_0 * (xMaxLimit * CGFloat(M_E));
    if (velocity.x > criticalVelocity) {
      velocity.x /= 1.5
      return true
      
    }else{
      return false
    }
  }
  
  func isNextDumping() -> Bool{
    let xMaxLimit:CGFloat = 0;
    let  criticalVelocity : CGFloat  = w_0 * (xMaxLimit * CGFloat(M_E));
    if (velocity.x < criticalVelocity) {
      velocity.x /= 1.5
      return true
      
    }else{
      return false
    }
  }
 
  
  
  func nextUnderDumping(){
      //  Limit x_max so that no more than 1 page is scrolled in one direction in one paging.
      let velocityMaxLimit:CGFloat = 180;
      if (velocity.x < -velocityMaxLimit) {
        velocity.x = -velocityMaxLimit;
      }
      self.calcDumpingVelocity(velocity)
  }
  
  func previosUnderDumping(){
    //  Limit x_max so that no more than 1 page is scrolled in one direction in one paging.
    let velocityMaxLimit:CGFloat = 180;
    if (velocity.x < -velocityMaxLimit) {
      velocity.x = -velocityMaxLimit;
    }
    self.calcDumpingVelocity(velocity)
   
  }
  
  func calcDumpingVelocity(velocity:CGPoint){
    A = 0;
    B = ( velocity.x) / w_d;
    let a:CGFloat  = B * w_d - A * zeta * w_0
    let b:CGFloat = A * w_d + B * zeta * w_0
    let sin_max:CGFloat = sqrt(a * a / (a * a + b * b))
    var theta_max:CGFloat = 0
    if (a * b > 0) {
      theta_max = asin(sin_max);
    } else {
      theta_max = CGFloat(M_PI) - asin(sin_max);
    }
    t_max = theta_max / w_d;
    if (t_max > 0) {
      x_max = pow(CGFloat(M_E), -zeta * w_0 * t_max) * (A * cos(w_d * t_max) + B * sin(w_d * t_max));
      
    }

  }
  
  
  
  func nextPageAnimationsCoordinatesArrayUnderDamping(underDamping:Bool,newCenter:CGPoint) -> [CGFloat]{
    let steps = 100;
    var pageAnimationValues = [CGFloat]();
    var value:CGFloat;
    for  var step = 0; step < steps; ++step {
      let t:CGFloat = 0.1 * CGFloat(step)
      if (underDamping) {
        value = pow(CGFloat(M_E), -zeta * w_0 * t) * (A * cos(w_d * t) + B * sin(w_d * t)) + newCenter.x;
      } else {
        value = pow(CGFloat(M_E), -w_0 * t) * (A + B * t) + newCenter.x;
      }
      pageAnimationValues.append(value)
      
    }
    return pageAnimationValues
    
  }
  
  
  
  
  func previousPageAnimationsCoordinatesArrayUnderDamping(underDamping:Bool,newCenter:CGPoint) -> [CGFloat]{
    let steps = 100;
    var pageAnimationValues = [CGFloat]();
    var value:CGFloat;
    for  var step = 0; step < steps; ++step {
      let t:CGFloat = 0.1 * CGFloat(step)
      if (underDamping) {
        value = pow(CGFloat(M_E), -zeta * w_0 * t) * (A * cos(w_d * t) + B * sin(w_d * t))  + newCenter.x;
      } else {
        value = pow(CGFloat(M_E), -w_0 * t) * (A + B * t) + newCenter.x;
      }
      pageAnimationValues.append(value)
     
    }
    return pageAnimationValues
    
  }
  
}


extension UIView{
  
  
  func addSwipeAnimation(delegate:NSObject,animationValues:[CGFloat],functionName:String = kCAMediaTimingFunctionLinear){
   let pageAnimation = CAKeyframeAnimation(keyPath: "position.x")  //[CAKeyframeAnimation animationWithKeyPath:@"position.x"];
    pageAnimation.delegate = delegate;
    pageAnimation.timingFunction = CAMediaTimingFunction(name: functionName)
    pageAnimation.values = animationValues;
    self.layer.addAnimation(pageAnimation, forKey: pageAnimation.keyPath)
  
  }
  
  
}
