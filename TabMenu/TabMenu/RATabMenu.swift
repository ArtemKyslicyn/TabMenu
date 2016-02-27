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


public class RATabMenu: UIViewController, UIScrollViewDelegate, UIGestureRecognizerDelegate {
  let menuScrollView = UIScrollView()
  let controllerScrollView = UIScrollView()
  
  private var settings = RATabMenuSettings()
  private var pageManager : RAPageManager!
  private var tabMenuAppeareance :TabMenuAppeareance!
  
  
  required public init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  public init(viewControllers: [UIViewController], frame: CGRect, settings: RATabMenuSettings) {
    super.init(nibName: nil, bundle: nil)
    self.settings  = settings
    pageManager.controllerArray = viewControllers
    tabMenuAppeareance = TabMenuAppeareance(menuScrollView: self.menuScrollView, controllerScrollView: controllerScrollView, settings: settings, view: self.view)
    self.view.frame = frame
    
  
  }
  
  
  



  
}
