//
//  RAPageController.swift
//  TabMenu
//
//  Created by Arcilite on 29.02.16.
//  Copyright © 2016 Arcilite. All rights reserved.
//

import UIKit


public class RAPageViewController: UIViewController {
  
 // weak public var delegate: UIPageViewControllerDelegate?
 // weak public var dataSource: UIPageViewControllerDataSource?
  // public var viewControllers: [UIViewController] = []
  //private var containerV
  //public var navigationOrientation: UIPageViewControllerNavigationOrientation!
  //private var previousViewController:UIViewController?
  //private var nexViewController:UIViewController?
  
  private var pageManager:RAContentPageManager!
  private var gestureHandler:RAGestureHandler!
  
 public  convenience   init(viewController:UIViewController) {
   
    self.init()
      pageManager = RAContentPageManager(rootViewController: self)
      pageManager.setContentController(viewController)
    
  }
  
  
  public init() {
    super.init(nibName: nil, bundle: nil)
    pageManager = RAContentPageManager(rootViewController: self)
    
  }

  required public init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
  }

  public func setCurrentController(viewController:UIViewController){
        pageManager.setContentController(viewController)
        
  }
  
  func gestureRecognizers() -> [UIGestureRecognizer]? {
    return self.view.gestureRecognizers
  }

  
  
//  func setViewControllers(viewControllers: [UIViewController], direction: UIPageViewControllerNavigationDirection, animated: Bool, completion: () -> Void) {
//   
//    let newViewController: UIViewController = viewControllers.last!
//    self.viewControllers = viewControllers
//    let oldViewController: UIViewController? = self.viewControllers.last
//    self.addChildViewController(oldViewController!)
//    newViewController.willMoveToParentViewController(self)
//    self.addChildViewController(newViewController)
//    newViewController.didMoveToParentViewController(self)
//   
//    if self.isViewLoaded() {
//      newViewController.beginAppearanceTransition(true, animated: animated)
//      
//    self.delegate?.pageViewController?( UIPageViewController(), willTransitionToViewControllers: [newViewController])
//      
//      if let oldViewController = oldViewController  {
//        var newFrame: CGRect = self.view.bounds
//        if direction == .Forward {
//          if navigationOrientation == .Horizontal {
//            newFrame.origin.x += CGRectGetWidth(self.view.bounds)
//          }
//          else {
//            newFrame.origin.y -= CGRectGetHeight(self.view.bounds)
//          }
//        }
//        else {
//          if navigationOrientation == .Horizontal {
//            newFrame.origin.x -= CGRectGetWidth(self.view.bounds)
//          }
//          else {
//            newFrame.origin.y += CGRectGetHeight(self.view.bounds)
//          }
//        }
//        newViewController.view.frame = newFrame
//        
//        let duration = animated ? self.animationDuration() : 0
//        self.transitionFromViewController(oldViewController, toViewController: newViewController, duration: duration, options: .CurveEaseOut, animations: {() -> Void in
//          
//          var oldFrame: CGRect = oldViewController.view.frame
//          let newFrame: CGRect = oldFrame
//          if direction == .Forward {
//            if self.navigationOrientation == .Horizontal {
//              oldFrame.origin.x -= CGRectGetWidth(self.view.bounds)
//            }
//            else {
//              oldFrame.origin.y += CGRectGetHeight(self.view.bounds)
//            }
//          }
//          else {
//            if self.navigationOrientation == .Horizontal {
//              oldFrame.origin.x += CGRectGetWidth(self.view.bounds)
//            }
//            else {
//              oldFrame.origin.y -= CGRectGetHeight(self.view.bounds)
//            }
//          }
//          oldViewController.view.frame = oldFrame
//          newViewController.view.frame = newFrame
//          }, completion: {(finished: Bool) -> Void in
//            newViewController.endAppearanceTransition()
//           
//              self.delegate?.pageViewController?(UIPageViewController(), didFinishAnimating: true, previousViewControllers: [oldViewController], transitionCompleted: true)
//            
//            oldViewController.removeFromParentViewController()
//        })
//      }
//      else {
//        //First time -> animation is different
//        newViewController.view.frame = self.view.bounds
//        
//        //self.animationDuration() * animated
//        let duration = animated ? self.animationDuration() : 0
//        
//        UIView.transitionWithView(self.view!, duration: duration, options: .CurveEaseOut, animations: {() -> Void in
//          self.view!.addSubview(newViewController.view!)
//          }, completion: {(finished: Bool) -> Void in
//            newViewController.endAppearanceTransition()
//           
//            self.delegate?.pageViewController?(UIPageViewController(), didFinishAnimating: true, previousViewControllers: [], transitionCompleted: true)
//          
//        })
//      }
//    }
//   
//  }
//  
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
      gestureHandler = RAGestureHandler(pageManager: pageManager)
//    let swipeLeftGestureRecognizer: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: "viewWasSwiped:")
//    swipeLeftGestureRecognizer.direction = .Left
//    self.view!.addGestureRecognizer(swipeLeftGestureRecognizer)
//    
//    let swipeRightGestureRecognizer: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: "viewWasSwiped:")
//    swipeRightGestureRecognizer.direction = .Right
//    
//    self.view!.addGestureRecognizer(swipeRightGestureRecognizer)
//    
//    let panRightGestureRecognizer: UIPanGestureRecognizer = UIPanGestureRecognizer(target: self, action: "panGestureMoved:")
    
   // self.view!.addGestureRecognizer(panRightGestureRecognizer)
    
//    if self.viewControllers.count > 0 {
//     
//      let newViewController: UIViewController = self.viewControllers.last!
//      newViewController.view.frame = self.view.bounds
//      self.view!.addSubview(newViewController.view!)
//    }
  }
  
  
  
  

  
  

  //

  //
  //- (void)pagingDidEnd
  //  {
  //    UIViewController *oldContentController = _contentController;
  //    CGPoint center = _contentController.view.center;
  //    CGRect bounds = self.view.bounds;
  //    if (center.x > CGRectGetMaxX(bounds) && _previousViewController != nil) {
  //      // Land in the previous page.
  //      _nextViewController = _contentController;
  //      self.contentController = _previousViewController;
  //      _previousViewController = _ppreviousViewController;
  //      _ppreviousViewController = nil;
  //
  //      _nextTitleView = _titleView;
  //      _titleView = _previousTitleView;
  //      _previousTitleView = _ppreviousTitleView;
  //      _ppreviousTitleView = nil;
  //      self.navigationItem.titleView.bounds = _titleView.bounds;
  //      _titleView.frame = self.navigationItem.titleView.bounds;
  //    } else if (center.x < CGRectGetMinX(bounds) && _nextViewController != nil) {
  //      // Land in the next page.
  //      _previousViewController = _contentController;
  //      self.contentController = _nextViewController;
  //      _nextViewController = _nnextViewController;
  //      _nnextViewController = nil;
  //
  //      _previousTitleView = _titleView;
  //      _titleView = _nextTitleView;
  //      _nextTitleView = _nnextTitleView;
  //      _nnextTitleView = nil;
  //      self.navigationItem.titleView.bounds = _titleView.bounds;
  //      _titleView.frame = self.navigationItem.titleView.bounds;
  //    } else {
  //      // Land in the current page.
  //      [self unloadInvisiblePages];
  //    }
  //
  //    _isTransitioningContentView = NO;
  //    _arePagingAnimationsCancelled = NO;
  //
  //    if ([_delegate respondsToSelector:@selector(pageViewController:didEndPagingViewController:)]) {
  //      [_delegate pageViewController:self didEndPagingViewController:oldContentController];
  //    }
}
