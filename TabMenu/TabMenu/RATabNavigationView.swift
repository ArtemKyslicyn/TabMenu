//
//  RATabNavigationView.swift
//  TabMenu
//
//  Created by Arcilite on 28.02.16.
//  Copyright © 2016 Arcilite. All rights reserved.
//

import UIKit

class NotificationView: UIImageView {
  var notificationLabel:UILabel!
  override init(frame:CGRect) {
    super.init(frame:frame)
    self.backgroundColor = UIColor.orangeColor()
    notificationLabel = UILabel()
    notificationLabel.frame.size = frame.size
    notificationLabel.text = "2"
    notificationLabel.textColor = UIColor.whiteColor()
    notificationLabel.textAlignment = .Center
    notificationLabel.font = UIFont.systemFontOfSize(16)
    self.addSubview(notificationLabel)
    self.layer.cornerRadius = 2
  }

  required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
  }
}

class RATabNavigationView: UIView {

  var notificationView:NotificationView!
  //var rightButton : UIButton!
  var leftButton : UIButton!
  var titleLabel : UILabel!
  
  
  override init(frame:CGRect) {
    super.init(frame:frame)
    self.backgroundColor = navColor
    titleLabel = UILabel()
    titleLabel.textAlignment = .Center
    titleLabel.font = UIFont.systemFontOfSize(21)
    self.addSubview(titleLabel)
   
    notificationView = NotificationView(frame: CGRectMake(frame.size.width - 30, (frame.size.height - 25)/2+10, 25, 25))
    
    self.addSubview(notificationView)
    
    
  }

  required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
  }
  
  override func layoutSubviews() {
     super.layoutSubviews()
     titleLabel.frame = CGRectMake((self.frame.size.width - titleLabel.intrinsicContentSize().width)/2, 15, titleLabel.intrinsicContentSize().width, self.frame.size.height-10)
  }
  
}
