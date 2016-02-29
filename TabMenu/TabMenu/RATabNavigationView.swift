//
//  RATabNavigationView.swift
//  TabMenu
//
//  Created by Arcilite on 28.02.16.
//  Copyright © 2016 Arcilite. All rights reserved.
//

import UIKit

class RATabNavigationView: UIView {

  var rightButton : UIButton!
  var leftButton : UIButton!
  var titleLabel : UILabel!
  
  override init(frame:CGRect) {
    super.init(frame:frame)
    self.backgroundColor = UIColor.blueColor()
  
  }

  required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
  }
  
  
}
