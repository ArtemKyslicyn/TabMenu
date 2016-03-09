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
  
  public var delegate: RAPageViewControllerDelegate?{
    set {
      pageManager.delegate = newValue
    }
    get {
      return pageManager.delegate
    }
  }
  weak public var dataSource: RAPageViewControllerDataSource?{
    
    set {
      print("print \(newValue)")
      self.pageManager.dataSource = newValue
    }
    get {
      return self.pageManager.dataSource
    }

  }
  
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
        pageManager.unloadAll()
        pageManager.setContentController(viewController)
        
  }
  
  func gestureRecognizers() -> [UIGestureRecognizer]? {
    return self.view.gestureRecognizers
  }

  
  


  func animationDuration() -> NSTimeInterval {
    return UIApplication.sharedApplication().statusBarOrientationAnimationDuration
  }
  
  override public func viewDidLoad() {
    super.viewDidLoad()
      gestureHandler = RAGestureHandler(pageManager: pageManager)
   }
  
  
  }
