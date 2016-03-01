//
//  RATabItem.swift
//  TabMenu
//
//  Created by Arcilite on 28.02.16.
//  Copyright © 2016 Arcilite. All rights reserved.
//

import UIKit

class RATabItem: UIButton {
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder:aDecoder)
  }
  
  init(frame:CGRect, title:String) {
    super.init(frame:frame)
    
    
    self.setTitle(title, forState: UIControlState.Normal)
    self.setTitleColor(titleTabColor, forState: UIControlState.Normal)
   // self.setTitleColor(UIColor(red: 66/255, green: 184/255, blue: 80/255, alpha: 1), forState: UIControlState.Selected)
    self.titleLabel?.font = UIFont.systemFontOfSize(32)
    
    
  }

  override func intrinsicContentSize() -> CGSize {
    
    var size = self.titleLabel!.intrinsicContentSize()
    
    size.width  = size.width + 10
    //size.width = CGFloat(self.filterWidth)
    size.height = self.frame.height
  
    return size
    
  }

 
}
