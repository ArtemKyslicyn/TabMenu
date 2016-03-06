//
//  RASwipeHandler.swift
//  TabMenu
//
//  Created by Arcilite on 24.02.16.
//  Copyright © 2016 Arcilite. All rights reserved.
//

import UIKit

public enum  RAScrollDirection : Int {
  case LeftPreviosPage
  case RightNextPage
  case Other
}

class RAGestureHandler: NSObject,UIGestureRecognizerDelegate {
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
  
  func panGestureMoved(gestureRecognizer:UIPanGestureRecognizer){
    
    // Elastic paging and bouncing modeled with damping.
    let w_0:CGFloat  = 0.7 // natural frequency
    let zeta:CGFloat = 0.8 // damping ratio for under-damping
    let w_d:CGFloat = w_0 * sqrt(1 - zeta * zeta); // damped frequency
  
    
    var velocity = gestureRecognizer.velocityInView(self.pageManager.rootViewController.view);
    // Scale velocity down.
    velocity.x /= 20
    velocity.y /= 20
    
    // Use critical damping to calculate the max displacement: x(t) = (A + B * t) * e^(-w_0 * t)
    // Use x(t)' = 0 to get the max x(t) — amplitude.
    // x(t)' = [B - w_0 * (A + B * t)] * e^(-w_0 * t)
    // x(t)' = 0 => t = 1 / w_0 - A / B.
    // x_max = (v_0 / w_0 + x_0) * e^[-v_0 / (v_0 + w_0 * x_0)]
    let A:CGFloat = 0;
    let B:CGFloat = velocity.x + w_0 * 0;
    let t_max = max(1 / w_0 - A / B, 0);
    let x_max = CGFloat(pow(M_E,Double( -w_0 * t_max))) * (A + B * t_max);
    //		NSLog(@"v_0 = %f, x_0 = %f, t_max = %f, x_max = %f", velocity.x, x_0, t_max, x_max);
    let direction =  self.loadPageByDirection(x_max, velocityx: velocity.x)
    self.restorePagesByDirection(direction)
   
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
      self.pageManager.loadPreviosPage()
      if (self.pageManager.isPreviosPageLoaded()) {
        direction = .LeftPreviosPage
      }
      
    }
    return direction
  }
  
  
  func restorePagesByDirection(direction:RAScrollDirection){
    switch direction{
    case .LeftPreviosPage:
      self.turnToPreviosPage()
    case .RightNextPage:
      self.turnToNextPage()
    case .Other:
      break;
    }
  }
  
  
  func turnToPreviosPage(){
    
  }
  
  
  func turnToNextPage(){
    
  }
  
  
  
}

class MathModelSwiping {
  var A:CGFloat = 0;
  var B:CGFloat = 0// = velocity.x + w_0 * 0;
  var t_max:CGFloat = 0 //= max(1 / w_0 - A / B, 0);
  var x_max:CGFloat = 0 // = CGFloat(pow(M_E,Double( -w_0 * t_max))) * (A + B * t_max);
  
}
