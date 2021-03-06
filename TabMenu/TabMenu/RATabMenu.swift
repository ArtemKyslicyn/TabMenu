//
//  TabMenu.swift
//  TabMenu
//
//  Created by Arcilite on 24.02.16.
//  Copyright © 2016 Arcilite. All rights reserved.
//

import UIKit

@objc public protocol RATabMenuDelegate {
  
  optional func willMoveToTabPage(controller: UIViewController, index: Int)
  optional func didMoveToTabPage(controller: UIViewController, index: Int)
}

func titlesFromViewControllers(viewControllers:[UIViewController])->[String]{
  var titles = [String]()
  for (index,viewController) in viewControllers.enumerate(){
    if let title  = viewController.title{
      titles.append(title)
    }else{
      titles.append("viewcontroller \(index)")
    }
  }
  return titles
}

public class RATabMenu: UIViewController, UIScrollViewDelegate, UIGestureRecognizerDelegate,RAPageViewControllerDataSource,RAPageViewControllerDelegate,RATabViewDelegate {
  
  let controllerScrollView = UIScrollView()
  
  private var settings = RATabMenuSettings()
//  private var pageManager : RAPageManager!
  private var tabMenuAppeareance :TabMenuAppeareance!
  private var navigationView:RATabNavigationView!
  private var tabView:RATabView!
  private var pageController:RAPageViewController!
  public var  pageViewControllers = [UIViewController]()
  
  required public init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
  
  
  public  init(viewControllers: [UIViewController], frame: CGRect, settings: RATabMenuSettings) {
    super.init(nibName: nil, bundle: nil)
    self.settings  = settings
    self.pageViewControllers = viewControllers
    
   
    //pageManager.controllerArray = viewControllers
    navigationView = RATabNavigationView(frame: CGRect( x: 0, y: 0,  width: self.view.frame.width, height: navigationHeight))
    self.view.addSubview(navigationView)
     let titles = titlesFromViewControllers (viewControllers)
    tabView = RATabView(frame:CGRect( x: 0, y: navigationView.frame.origin.x + navigationHeight,  width: self.view.frame.width, height: tabHeight),titles:titles)
    tabView.delegate = self
    self.view.addSubview(tabView)
    
    pageController = RAPageViewController()
    pageController.view.frame = CGRectMake(0, navigationHeight+tabHeight, self.view.frame.width, self.view.frame.height-navigationHeight+tabHeight)

    pageController.view.backgroundColor = UIColor.brownColor()
    
    pageController.dataSource = self
    pageController.delegate = self
    //pageController.doubleSided = false
    self.view.addSubview(pageController.view)
    
   
   //tabMenuAppeareance = TabMenuAppeareance(menuScrollView: self.menuScrollView, controllerScrollView: controllerScrollView, settings: settings, view: self.view)
    self.view.frame = frame
    
    self.addChildViewController(pageController)
  
    self.setPageIndex(0)
    
    pageController.didMoveToParentViewController(self)
    //self.view.gestureRecognizers = pageController.gestureRecognizers
  }
  
  public override func viewDidLoad() {
    super.viewDidLoad()

  
  }
  
  func setPageIndex(index:Int){
    tabView.selectedTabIndex(index)
    navigationView.titleLabel.text = pageViewControllers[index].title
   
    pageController.setCurrentController(pageViewControllers[index])
//    pageController.setViewControllers([pageViewControllers[index]], direction: .Forward, animated: true) { (isComplete) -> Void in
//      
//    }
  }
  
  func selectedTabIndex(index:Int){
    self.setPageIndex(index)
  }
  

  
  public func pageViewController(pageViewController: RAPageViewController,
    viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
      navigationView.titleLabel.text = viewController.title
      navigationView.setNeedsLayout()

      guard let viewControllerIndex = pageViewControllers.indexOf(viewController) else {
        return nil
      }
      tabView.selectedTabIndex(viewControllerIndex)
      
      let previousIndex = viewControllerIndex - 1
      
      // User is on the first view controller and swiped left to loop to
      // the last view controller.
      guard previousIndex >= 0 else {
        return nil
      }
      
      guard pageViewControllers.count > previousIndex else {
        return nil
      }
      tabView.selectedTabIndex(viewControllerIndex)
      let previosController = pageViewControllers[previousIndex]
      return previosController
  }
  
  public func pageViewController(pageViewController: RAPageViewController,
    viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
    
      navigationView.titleLabel.text = viewController.title
      navigationView.setNeedsLayout()
      
      guard let viewControllerIndex = pageViewControllers.indexOf(viewController) else {
        return nil
      }
      tabView.selectedTabIndex(viewControllerIndex)
      
      let nextIndex = viewControllerIndex + 1
      let orderedViewControllersCount = pageViewControllers.count
      

      guard orderedViewControllersCount > nextIndex else {
        return nil
      }
      let nextController =  pageViewControllers[nextIndex]
      return nextController
     
  }
  

 

  
}
