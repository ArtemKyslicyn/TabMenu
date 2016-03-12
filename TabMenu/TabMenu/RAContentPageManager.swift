//
//  RAContentViewController.swift
//  TabMenu
//
//  Created by Arcilite on 04.03.16.
//  Copyright © 2016 Arcilite. All rights reserved.
//

import UIKit

@objc public protocol RAPageViewControllerDelegate {
  
  optional func pageViewController(pageViewController: RAPageViewController, willTransitionToViewControllers pendingViewControllers: [UIViewController])
  
  optional  func pageViewController(pageViewController: RAPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool)

  optional  func pageViewController(pageViewController: RAPageViewController, spineLocationForInterfaceOrientation orientation: UIInterfaceOrientation) -> UIPageViewControllerSpineLocation
  

  optional  func pageViewControllerSupportedInterfaceOrientations(pageViewController: RAPageViewController) -> UIInterfaceOrientationMask

  optional  func pageViewControllerPreferredInterfaceOrientationForPresentation(pageViewController: RAPageViewController) -> UIInterfaceOrientation
}

@objc public protocol RAPageViewControllerDataSource {
  
   func pageViewController(pageViewController: RAPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController?
 
   func pageViewController(pageViewController: RAPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController?

}


public class RAContentPageManager: NSObject {
  
  var rootViewController:RAPageViewController!
  var contentViewController:UIViewController!
  
  var previousViewController:UIViewController?
  var nextViewController:UIViewController?
  
  
  public var delegate: RAPageViewControllerDelegate?
  public var dataSource: RAPageViewControllerDataSource?
  
  init(rootViewController:RAPageViewController){
    super.init()
    self.rootViewController = rootViewController
    
  }

  func setContentController(contentViewController:UIViewController?){
   
    if self.contentViewController == contentViewController{
      return;
    }
    
    self.unloadNonActiveControllers()
    
    contentViewController?.willMoveToParentViewController(nil)
    if let contentViewController = contentViewController{
        rootViewController.addChildViewController(contentViewController)
      
        if rootViewController.isViewLoaded(){
          if contentViewController.view.superview == rootViewController.view{
            contentViewController.view.removeFromSuperview()
          }else{
            
            rootViewController.view.addSubview(contentViewController.view)
          }
          rootViewController.didMoveToParentViewController(rootViewController)
          self.contentViewController = contentViewController
        }
    }
    
  }
 
}

extension RAContentPageManager{
  
  func loadPreviosPage() -> UIViewController?{
    print(self.dataSource)
    guard let previousViewController = self.dataSource!.pageViewController(rootViewController, viewControllerBeforeViewController: contentViewController) else {
      return nil
    }
    let isNewViewController = !rootViewController.childViewControllers.contains(previousViewController);
    if (isNewViewController) {
      rootViewController.addChildViewController(previousViewController);
    }
    var previousFrame = contentViewController.view.frame;
    previousFrame.origin.x -=   rootViewController.view.bounds.size.width;
    previousViewController.view.frame = previousFrame;
    rootViewController.view.addSubview(previousViewController.view)
    
    if (isNewViewController) {
      previousViewController.didMoveToParentViewController(rootViewController)
    }
    return previousViewController
  }
  
  func loadNextPage() -> UIViewController?{
    print(self.dataSource)
    guard let nextViewController = self.dataSource?.pageViewController(rootViewController, viewControllerAfterViewController: contentViewController) else {
      return nil
    }
    
    let isNewViewController = !rootViewController.childViewControllers.contains(nextViewController);
    if (isNewViewController) {
      rootViewController.addChildViewController(nextViewController);
    }
    
    var nextFrame = self.contentViewController.view.frame;
    nextFrame.origin.x +=   rootViewController.view.bounds.size.width;
    nextViewController.view.frame = nextFrame;
    rootViewController.view.addSubview(nextViewController.view)
    
    if (isNewViewController) {
      nextViewController.didMoveToParentViewController(rootViewController)
    }
    
    return nextViewController
  }
  
  func pagingDidEnd(){
    //let oldContentController = contentViewController
    let center = contentViewController.view.center;
    let bounds = rootViewController.view.bounds;
    if  let previousViewController  = self.previousViewController  where center.x > CGRectGetMaxX(bounds)  {
      self.nextViewController = self.contentViewController
      self.contentViewController = previousViewController;
    }else if let nexViewController = self.nextViewController where center.x < CGRectGetMaxX(bounds){
      self.previousViewController = self.contentViewController;
      self.contentViewController = nexViewController
    }else{
      self.unloadNonActiveControllers()
    }
  }
  
  func unloadAll(){
    for vc in rootViewController.childViewControllers{
      if vc != contentViewController{
      vc.willMoveToParentViewController(nil)
      vc.view.removeFromSuperview()
      vc.removeFromParentViewController()
      }
    }
  }
  
  func unloadNonActiveControllers(){
    
    let bounds = rootViewController.view.bounds
    var vcUnloads = [UIViewController]()
    
    for vc in rootViewController.childViewControllers{
      if !CGRectIntersectsRect(bounds, vc.view.frame){
        vcUnloads.append(vc)
      }
    }
    
    for vc in vcUnloads{
      if vc == previousViewController{
        previousViewController = nil
      }
      if vc == nextViewController{
        nextViewController = nil
      }
      vc.willMoveToParentViewController(nil)
      vc.view.removeFromSuperview()
      vc.removeFromParentViewController()
      if self.rootViewController.parentViewController == nil {
        vc.viewDidDisappear(false)
      }
    }
    
    
  }
  
  func loadNextNotLoadedPage()  {
    if !isNextPageLoaded(){
      nextViewController = self.loadNextPage()
    }
  }
  
  func loadPreviosNotLoadePage(){
    if !isPreviosPageLoaded(){
      previousViewController = self.loadPreviosPage()
    }
  }
  
  func isNextPageLoaded()-> Bool{
    if nextViewController == nil {
      return false
    }else{
      return true
    }
    
  }
  
  func isPreviosPageLoaded()-> Bool{
    if previousViewController == nil{
      return false
    }else{
      return true
    }

  }
  
  
  
}