//
//  RAPageController.swift
//  TabMenu
//
//  Created by Arcilite on 29.02.16.
//  Copyright © 2016 Arcilite. All rights reserved.
//

import UIKit


public class RAPageViewController: RAContentViewController {
  
  weak public var delegate: UIPageViewControllerDelegate?
  weak public var dataSource: UIPageViewControllerDataSource?
  public var viewControllers: [UIViewController] = []
  //private var containerV
  public var navigationOrientation: UIPageViewControllerNavigationOrientation!
  private var previousViewController:UIViewController?
  private var nexViewController:UIViewController?
  
  
  
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
   
    let newViewController: UIViewController = viewControllers.last!
    self.viewControllers = viewControllers
    let oldViewController: UIViewController? = self.viewControllers.last
    self.addChildViewController(oldViewController!)
    newViewController.willMoveToParentViewController(self)
    self.addChildViewController(newViewController)
    newViewController.didMoveToParentViewController(self)
   
    if self.isViewLoaded() {
      newViewController.beginAppearanceTransition(true, animated: animated)
      
    self.delegate?.pageViewController?( UIPageViewController(), willTransitionToViewControllers: [newViewController])
      
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
           
              self.delegate?.pageViewController?(UIPageViewController(), didFinishAnimating: true, previousViewControllers: [oldViewController], transitionCompleted: true)
            
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
           
            self.delegate?.pageViewController?(UIPageViewController(), didFinishAnimating: true, previousViewControllers: [], transitionCompleted: true)
          
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
    
    let panRightGestureRecognizer: UIPanGestureRecognizer = UIPanGestureRecognizer(target: self, action: "panGestureMoved:")
    
   // self.view!.addGestureRecognizer(panRightGestureRecognizer)
    
    if self.viewControllers.count > 0 {
     
      let newViewController: UIViewController = self.viewControllers.last!
      newViewController.view.frame = self.view.bounds
      self.view!.addSubview(newViewController.view!)
    }
  }
  
  func panGestureMoved(sender:UIPanGestureRecognizer){
    
  }
  
   func viewWasSwiped(sender: UISwipeGestureRecognizer) {
    let oldViewController: UIViewController? = self.viewControllers.last
    var newViewController: UIViewController? = nil
    var direction: UIPageViewControllerNavigationDirection = .Forward
    switch sender.direction {
    case UISwipeGestureRecognizerDirection.Right:
      newViewController = self.dataSource?.pageViewController( UIPageViewController(), viewControllerBeforeViewController: oldViewController!)
      direction = .Reverse
      
    case UISwipeGestureRecognizerDirection.Left:
      newViewController = self.dataSource!.pageViewController(UIPageViewController(), viewControllerAfterViewController: oldViewController!)
      direction = .Forward
    default:
      break
    }
    
    if let newViewController = newViewController,oldViewController = oldViewController {
      newViewController.willMoveToParentViewController(self)
      self.addChildViewController(oldViewController)
      self.addChildViewController(newViewController)
    
      //self.view.addSubview(oldViewController.view)
      self.view.addSubview(newViewController.view)
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
      newViewController.endAppearanceTransition()
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
          oldViewController.view.removeFromSuperview()
          // self.addChildViewController(newViewController)
         // self.view.addSubview(newViewController.view)
          self.delegate?.pageViewController?(UIPageViewController(), didFinishAnimating: true, previousViewControllers: [oldViewController], transitionCompleted: true)
          
      })
    }
  }
  
  
  
  func loadPreviosPage() -> UIViewController?{
    guard let previousViewController = self.dataSource?.pageViewController(UIPageViewController(), viewControllerBeforeViewController: contentViewController) else {
      return nil
    }
    let isNewViewController = !self.childViewControllers.contains(previousViewController);
    if (isNewViewController) {
      self.addChildViewController(previousViewController);
    }
    var previousFrame = self.contentViewController.view.frame;
    previousFrame.origin.x -=   self.view.bounds.size.width;
    previousViewController.view.frame = previousFrame;
    self.view.addSubview(previousViewController.view)
    
    if (isNewViewController) {
      previousViewController.didMoveToParentViewController(self)
    }
    return previousViewController
  }
  
  func loadNextPage() -> UIViewController?{
     return nil
  }
  
  

}
