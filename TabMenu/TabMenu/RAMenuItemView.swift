//
//  RAMenuItemView.swift
//  TabMenu
//
//  Created by Arcilite on 24.02.16.
//  Copyright © 2016 Arcilite. All rights reserved.
//

import UIKit

class RAMenuItemView: UIView {
  
  var titleLabel : UILabel?
  var menuItemSeparator : UIView?
  
  func setUpMenuItemView(menuItemWidth: CGFloat, menuScrollViewHeight: CGFloat, indicatorHeight: CGFloat, separatorPercentageHeight: CGFloat, separatorWidth: CGFloat, separatorRoundEdges: Bool, menuItemSeparatorColor: UIColor) {
    titleLabel = UILabel(frame: CGRectMake(0.0, 0.0, menuItemWidth, menuScrollViewHeight - indicatorHeight))
    
    menuItemSeparator = UIView(frame: CGRectMake(menuItemWidth - (separatorWidth / 2), floor(menuScrollViewHeight * ((1.0 - separatorPercentageHeight) / 2.0)), separatorWidth, floor(menuScrollViewHeight * separatorPercentageHeight)))
    menuItemSeparator!.backgroundColor = menuItemSeparatorColor
    
    if separatorRoundEdges {
      menuItemSeparator!.layer.cornerRadius = menuItemSeparator!.frame.width / 2
    }
    
    menuItemSeparator!.hidden = true
    self.addSubview(menuItemSeparator!)
    
    self.addSubview(titleLabel!)
  }
  
  func setTitleText(text: NSString) {
    if titleLabel != nil {
      titleLabel!.text = text as String
      titleLabel!.numberOfLines = 0
      titleLabel!.sizeToFit()
    }
  }


}
