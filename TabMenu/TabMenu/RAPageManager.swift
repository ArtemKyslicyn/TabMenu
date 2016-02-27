//
//  RAPageManager.swift
//  TabMenu
//
//  Created by Arcilite on 26.02.16.
//  Copyright © 2016 Arcilite. All rights reserved.
//

import UIKit

class RAPageManager: NSObject {
      var pagesAddedDictionary : [Int : Int] = [:]
      var controllerArray : [UIViewController] = []
      var menuItems : [RAMenuItemView] = []
      var menuItemWidths : [CGFloat] = []
  
      private var scrollViewHandler:RAScrollViewHandler!
      private var gestureHandler : RAGestureHandler!
  
  
  
  
  func configureUserInterface(menuScrollView:UIScrollView,controllerScrollView:UIScrollView,settings:RATabMenuSettings,view:UIView) {
    self.setupGestureHandler(menuScrollView)
    
    controllerScrollView.delegate = scrollViewHandler
    
    menuScrollView.scrollsToTop = false;
    controllerScrollView.scrollsToTop = false;
    

    // Set new content size for menu scroll view if needed
    
    menuScrollView.contentSize = CGSizeMake((settings.totalMenuItemWidthIfDifferentWidths + menuMargin) + CGFloat(controllerArray.count) * semenuMargin, menuHeight)
    
    
    // Set selected color for title label of selected menu item
    if menuItems.count > 0 {
      if menuItems[currentPageIndex].titleLabel != nil {
        menuItems[currentPageIndex].titleLabel!.textColor = selectedMenuItemLabelColor
      }
    }
     
    
      self.configureMenuItemWidthBasedOnTitleTextWidthAndCenterMenuItems()
      let leadingAndTrailingMargin = self.getMarginForMenuItemWidthBasedOnTitleTextWidthAndCenterMenuItems()
    
   
  }
  
  func setupGestureHandler(menuScrollView:UIScrollView){
    let menuItemTapGestureRecognizer = UITapGestureRecognizer(target: self, action: Selector("handleMenuItemTap:"))
    menuItemTapGestureRecognizer.numberOfTapsRequired = 1
    menuItemTapGestureRecognizer.numberOfTouchesRequired = 1
    menuItemTapGestureRecognizer.delegate = RAGestureHandler()
    menuScrollView.addGestureRecognizer(menuItemTapGestureRecognizer)
  }
  
  func createMenuItemsForControllers(menuScrollView:UIScrollView,settings:RATabMenuSettings){
    var index  = 0
    
    for controller in controllerArray {
      if index == 0 {
        // Add first two controllers to scrollview and as child view controller
        addPageAtIndex(0)
      }
     
      let menuItemView = createTabItemByIndexWithSettings(controller.title, index: index, settings: settings)
      menuScrollView.addSubview(menuItemView)
      menuItems.append(menuItemView)
      menuItemWidths.append(menuItemView.frame.size.width)
      
      index++
    }
    
  }
  
  func createTabItemByIndexWithSettings(controllerTitle:String?,index:Int,settings:RATabMenuSettings)->RAMenuItemView{
    
    var menuItemFrame : CGRect = CGRect()
    
    
    let titleText : String = controllerTitle != nil ? controllerTitle! : "Menu \(index) + 1)"
    
    let itemWidthRect : CGRect = (titleText as NSString).boundingRectWithSize(CGSizeMake(1000, 1000), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: [NSFontAttributeName:settings.menuItemFont], context: nil)
    
    menuItemFrame = CGRectMake(settings.totalMenuItemWidthIfDifferentWidths + settings.menuMargin + (settings.menuMargin * CGFloat(index)), 0.0, itemWidthRect.width, settings.menuHeight)
    
    settings.totalMenuItemWidthIfDifferentWidths += itemWidthRect.width
   
    
    
    let menuItemView  = RAMenuItemView(frame: menuItemFrame)
    
    menuItemView.setUpMenuItemView(itemWidthRect.width, menuScrollViewHeight: settings.menuHeight, indicatorHeight: settings.selectionIndicatorHeight,separatorPercentageHeight: settings.menuItemSeparatorPercentageHeight, separatorWidth: settings.menuItemSeparatorWidth, separatorRoundEdges: settings.menuItemSeparatorRoundEdges, menuItemSeparatorColor: settings.menuItemSeparatorColor)
    
    
    menuItemView.titleLabel!.font = settings.menuItemFont
    
    menuItemView.titleLabel!.textAlignment = NSTextAlignment.Center
    menuItemView.titleLabel!.textColor = settings.unselectedMenuItemLabelColor
    menuItemView.titleLabel!.adjustsFontSizeToFitWidth = true
    
    return menuItemView
    
  }

}

