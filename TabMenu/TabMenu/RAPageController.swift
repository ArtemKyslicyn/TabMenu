//
//  RAPageController.swift
//  TabMenu
//
//  Created by Arcilite on 29.02.16.
//  Copyright © 2016 Arcilite. All rights reserved.
//

import UIKit

public class RAPageViewController:UIViewController {
  
  weak public var delegate: UIPageViewControllerDelegate?
  weak public var dataSource: UIPageViewControllerDataSource?
  public var viewControllers: [UIViewController] = []
  public var navigationOrientation: UIPageViewControllerNavigationOrientation!
  
  convenience  init(transitionStyle: UIPageViewControllerTransitionStyle, navigationOrientation: UIPageViewControllerNavigationOrientation, options: [NSObject : AnyObject]?) {
    //NSParameterAssert(transitionStyle == .Scroll)
    self.init()
   
      //self.transitionStyle = transitionStyle
      self.navigationOrientation = navigationOrientation
    
  }
  
  func gestureRecognizers() -> [UIGestureRecognizer]? {
    return self.view.gestureRecognizers
  }

  
  func setViewControllers(viewControllers: [UIViewController], direction: UIPageViewControllerNavigationDirection, animated: Bool, completion: () -> Void) {
    self.viewControllers = viewControllers
    let newViewController: UIViewController = viewControllers.last!
   
    let oldViewController: UIViewController? = self.viewControllers.last
    self.addChildViewController(oldViewController!)
    newViewController.willMoveToParentViewController(self)
    self.addChildViewController(newViewController)
    newViewController.didMoveToParentViewController(self)
   
    if self.isViewLoaded() {
      newViewController.beginAppearanceTransition(true, animated: animated)
      
      if ((self.delegate?.respondsToSelector("pageViewController:willTransitionToViewControllers:")) != nil) {
        self.delegate?.pageViewController?( UIPageViewController(), willTransitionToViewControllers: [newViewController])
      }
      
      if let oldViewController = oldViewController  {
        var newFrame: CGRect = self.view.bounds
        if direction == .Forward {
          if navigationOrientation == .Horizontal {
            newFrame.origin.x += CGRectGetWidth(self.view.bounds)
          }
          else {
            newFrame.origin.y -= CGRectGetHeight(self.view.bounds)
          }
        }
        else {
          if navigationOrientation == .Horizontal {
            newFrame.origin.x -= CGRectGetWidth(self.view.bounds)
          }
          else {
            newFrame.origin.y += CGRectGetHeight(self.view.bounds)
          }
        }
        newViewController.view.frame = newFrame
        
        let duration = animated ? self.animationDuration() : 0
        self.transitionFromViewController(oldViewController, toViewController: newViewController, duration: duration, options: .CurveEaseOut, animations: {() -> Void in
          
          var oldFrame: CGRect = oldViewController.view.frame
          let newFrame: CGRect = oldFrame
          if direction == .Forward {
            if self.navigationOrientation == .Horizontal {
              oldFrame.origin.x -= CGRectGetWidth(self.view.bounds)
            }
            else {
              oldFrame.origin.y += CGRectGetHeight(self.view.bounds)
            }
          }
          else {
            if self.navigationOrientation == .Horizontal {
              oldFrame.origin.x += CGRectGetWidth(self.view.bounds)
            }
            else {
              oldFrame.origin.y -= CGRectGetHeight(self.view.bounds)
            }
          }
          oldViewController.view.frame = oldFrame
          newViewController.view.frame = newFrame
          }, completion: {(finished: Bool) -> Void in
            newViewController.endAppearanceTransition()
            if ((self.delegate?.respondsToSelector("pageViewController:didFinishAnimating:previousViewControllers:transitionCompleted:")) != nil) {
              self.delegate?.pageViewController!(UIPageViewController(), didFinishAnimating: true, previousViewControllers: [oldViewController], transitionCompleted: true)
            }
            oldViewController.removeFromParentViewController()
        })
      }
      else {
        //First time -> animation is different
        newViewController.view.frame = self.view.bounds
        
        //self.animationDuration() * animated
        let duration = animated ? self.animationDuration() : 0
        
        UIView.transitionWithView(self.view!, duration: duration, options: .CurveEaseOut, animations: {() -> Void in
          self.view!.addSubview(newViewController.view!)
          }, completion: {(finished: Bool) -> Void in
            newViewController.endAppearanceTransition()
            if ((self.delegate?.respondsToSelector("pageViewController:didFinishAnimating:previousViewControllers:transitionCompleted:")) != nil) {
              self.delegate!.pageViewController!(UIPageViewController(), didFinishAnimating: true, previousViewControllers: [], transitionCompleted: true)
            }
        })
      }
    }
   
  }
  
//  func viewControllers() -> [UIViewController] {
//    var children: [UIViewController] = self.childViewControllers
//    //0: empty, 1: static, 2:transitioning
//    return children
//  }
  

  func animationDuration() -> NSTimeInterval {
    return UIApplication.sharedApplication().statusBarOrientationAnimationDuration
  }
  
  override public func viewDidLoad() {
    super.viewDidLoad()
    let swipeLeftGestureRecognizer: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: "viewWasSwiped:")
    swipeLeftGestureRecognizer.direction = .Left
    self.view!.addGestureRecognizer(swipeLeftGestureRecognizer)
    let swipeRightGestureRecognizer: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: "viewWasSwiped:")
    swipeRightGestureRecognizer.direction = .Right
    self.view!.addGestureRecognizer(swipeRightGestureRecognizer)
    if self.viewControllers.count > 0 {
     
      let newViewController: UIViewController = self.viewControllers.last!
      newViewController.view.frame = self.view.bounds
      self.view!.addSubview(newViewController.view!)
    }
  }
  
   func viewWasSwiped(sender: UISwipeGestureRecognizer) {
    let oldViewController: UIViewController? = self.viewControllers.last
    var newViewController: UIViewController? = nil
    var direction: UIPageViewControllerNavigationDirection = .Forward
    switch sender.direction {
    case UISwipeGestureRecognizerDirection.Right:
      newViewController = self.dataSource!.pageViewController( UIPageViewController(), viewControllerBeforeViewController: oldViewController!)
      direction = .Reverse
      
    case UISwipeGestureRecognizerDirection.Left:
      newViewController = self.dataSource!.pageViewController(UIPageViewController(), viewControllerAfterViewController: oldViewController!)
      
    default:
      break
    }
    
    if let newViewController = newViewController,oldViewController = oldViewController {
      newViewController.willMoveToParentViewController(self)
      self.addChildViewController(newViewController)
      newViewController.didMoveToParentViewController(self)
      newViewController.beginAppearanceTransition(true, animated: true)
      var newFrame: CGRect = self.view.bounds
     
      if direction == .Forward {
        if navigationOrientation == .Horizontal {
          newFrame.origin.x += CGRectGetWidth(self.view.bounds)
        }
        else {
          newFrame.origin.y -= CGRectGetHeight(self.view.bounds)
        }
      }
      else {
        if navigationOrientation == .Horizontal {
          newFrame.origin.x -= CGRectGetWidth(self.view.bounds)
        }
        else {
          newFrame.origin.y += CGRectGetHeight(self.view.bounds)
        }
      }
      newViewController.view.frame = newFrame
      newViewController.view.alpha = 0.0
      
        self.delegate?.pageViewController?(UIPageViewController(), willTransitionToViewControllers: [newViewController])
    
      self.transitionFromViewController(oldViewController, toViewController: newViewController, duration: self.animationDuration(), options: .CurveEaseOut, animations: {() -> Void in
        var oldFrame: CGRect = oldViewController.view.frame
        let newFrame: CGRect = oldFrame
        if direction == .Forward {
          if self.navigationOrientation == .Horizontal {
            oldFrame.origin.x -= CGRectGetWidth(self.view.bounds)
          }
          else {
            oldFrame.origin.y += CGRectGetHeight(self.view.bounds)
          }
        }
        else {
          if self.navigationOrientation == .Horizontal {
            oldFrame.origin.x += CGRectGetWidth(self.view.bounds)
          }
          else {
            oldFrame.origin.y -= CGRectGetHeight(self.view.bounds)
          }
        }
        oldViewController.view.frame = oldFrame
        newViewController.view.frame = newFrame
        oldViewController.view.alpha = 0.0
        newViewController.view.alpha = 1.0
        }, completion: {(finished: Bool) -> Void in
          
          newViewController.endAppearanceTransition()
          oldViewController.removeFromParentViewController()
          self.delegate?.pageViewController?(UIPageViewController(), didFinishAnimating: true, previousViewControllers: [oldViewController], transitionCompleted: true)
          
      })
    }
  }
}
