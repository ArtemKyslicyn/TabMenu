//
//  TabView.swift
//  TabMenu
//
//  Created by Arcilite on 27.02.16.
//  Copyright © 2016 Arcilite. All rights reserved.
//

import UIKit

protocol RATabViewDelegate {
  func selectedTabIndex(index:Int)
}

class RATabView: UIView {

  let menuScrollView = UIScrollView()
  var buttons = [RATabItem]()
  var delegate : RATabViewDelegate?
  
  init(frame:CGRect, titles:[String]) {
    super.init(frame:frame)
    self.backgroundColor = tabColor
    menuScrollView.frame.size = frame.size
    menuScrollView.backgroundColor = tabColor
    self.addSubview(menuScrollView)
    self.setupViewWithFrame(frame, titlesArray: titles)
    
  }

  required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
  }
  
  func setupViewWithFrame(frame:CGRect,titlesArray:[String]){
    var contentOffset:CGFloat = self.frame.width/2
    for (index,title) in titlesArray.enumerate() {
      let button = RATabItem(frame:CGRectMake(contentOffset, 0, 0, frame.size.height), title:title)
      //button.backgroundColor = UIColor.orangeColor()
      //
      contentOffset +=  button.intrinsicContentSize().width
      button.frame.size.width = button.intrinsicContentSize().width
      button.tag = index
      button.backgroundColor = UIColor.orangeColor()
      button.addTarget(self, action: "selectTab:", forControlEvents: UIControlEvents.TouchUpInside)
      buttons.append(button)
      menuScrollView.addSubview(button)
    }
    menuScrollView.contentSize = CGSizeMake(contentOffset + self.frame.width/2
, tabHeight)
     self.setNeedsLayout()
  }
  
  func selectTab(sender:UIButton){
      delegate?.selectedTabIndex(sender.tag)
  }
  
  func selectedTabIndex(index:Int){
   let button = buttons[index]
   // let newContentOffsetX :CGFloat = (menuScrollView.contentSize.width/2) - (menuScrollView.bounds.size.width/2);
    let centerButton = button.center
//    var xofsset = menuScrollView.contentSize.width - button.frame.origin.x - button.frame.size.width
//    if xofsset > menuScrollView.contentSize.width{
//      //xofsset = centerButton
//       xofsset = menuScrollView.contentSize.width/2
//    }else{
//     xofsset = 50
//    }
// 
   // if center.x < menuScrollView.contentSize.width{
        let offset =   (menuScrollView.contentSize.width / CGFloat(buttons.count) ) *  CGFloat(index)
   let point = CGPointMake(offset, 0)
  
    self.menuScrollView.setContentOffset(point, animated: true)
  //  }
  }

}
