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


class RATabMenu: UIViewController, UIScrollViewDelegate, UIGestureRecognizerDelegate {
  let menuScrollView = UIScrollView()
  let controllerScrollView = UIScrollView()
  var controllerArray : [UIViewController] = []
  var menuItems : [RAMenuItemView] = []
  var menuItemWidths : [CGFloat] = []
  let settings = RATabMenuSettings()
  
}
