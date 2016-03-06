//
//  RATabMenuSettings.swift
//  TabMenu
//
//  Created by Arcilite on 24.02.16.
//  Copyright © 2016 Arcilite. All rights reserved.
//

import UIKit
//
//public enum  RAScrollDirection : Int {
//  case Left
//  case Right
//  case Other
//}

public class RATabMenuSettings: NSObject {

  public var menuHeight : CGFloat = 34.0
  public var menuMargin : CGFloat = 15.0
 
  var totalMenuItemWidthIfDifferentWidths : CGFloat = 0.0
  public var scrollAnimationDurationOnMenuItemTap : Int = 500 // Millisecons
  var startingMenuMargin : CGFloat = 0.0
  var menuItemMargin : CGFloat = 0.0
  
  
  var currentPageIndex : Int = 0
  var lastPageIndex : Int = 0
  
  public var selectedMenuItemLabelColor : UIColor = UIColor.whiteColor()
  public var unselectedMenuItemLabelColor : UIColor = UIColor.lightGrayColor()
  public var scrollMenuBackgroundColor : UIColor = UIColor.blackColor()
  public var viewBackgroundColor : UIColor = UIColor.whiteColor()
  public var bottomMenuHairlineColor : UIColor = UIColor.whiteColor()
  public var menuItemSeparatorColor : UIColor = UIColor.lightGrayColor()
  
  public var menuItemFont : UIFont = UIFont.systemFontOfSize(15.0)
  public var menuItemSeparatorPercentageHeight : CGFloat = 0.2
  public var menuItemSeparatorWidth : CGFloat = 0.5
  public var menuItemSeparatorRoundEdges : Bool = false
  
  public var addBottomMenuHairline : Bool = true

  public var centerMenuItems : Bool = false
  public var enableHorizontalBounce : Bool = true
  public var hideTopMenuBar : Bool = false
  
  var currentOrientationIsPortrait : Bool = true
  var pageIndexForOrientationChange : Int = 0
  var didLayoutSubviewsAfterRotation : Bool = false
  var didScrollAlready : Bool = false
  
  var lastControllerScrollViewContentOffset : CGFloat = 0.0
  
  var lastScrollDirection : RAScrollDirection = .Other
  var startingPageForScroll : Int = 0
  var didTapMenuItemToScroll : Bool = false
  

}
