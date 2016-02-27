//
//  TabMenuAppeareanceSetup.swift
//  TabMenu
//
//  Created by Arcilite on 25.02.16.
//  Copyright © 2016 Arcilite. All rights reserved.
//

import UIKit

class TabMenuAppeareance: NSObject {
  
 
  
  init(menuScrollView:UIScrollView,controllerScrollView:UIScrollView,settings:RATabMenuSettings,view:UIView) {
    super.init()
    self.setupUserInterface(menuScrollView, controllerScrollView: controllerScrollView, settings: settings, view: view)
  }
  
  
private  func setupUserInterface(menuScrollView:UIScrollView,controllerScrollView:UIScrollView,settings:RATabMenuSettings,view:UIView) {
    
    let viewsDictionary = ["menuScrollView":menuScrollView, "controllerScrollView":controllerScrollView]
    
    self.setupControllerScrollView(controllerScrollView,view: view,settings: settings)
    
    self.addControllerScrollViewConstraints(viewsDictionary,view: view)
    
    // Set up menu scroll view
    self.setupMenuScrollView(menuScrollView,settings: settings,view: view)
    
    self.addMenuScrollViewConstraints(viewsDictionary,settings: settings,view: view)
    
    
    // Add hairline to menu scroll view
    if settings.addBottomMenuHairline {
      self.setupBottomHairLine(settings,view: view)
    }
    
    // Disable scroll bars
    menuScrollView.showsHorizontalScrollIndicator = false
    menuScrollView.showsVerticalScrollIndicator = false
    controllerScrollView.showsHorizontalScrollIndicator = false
    controllerScrollView.showsVerticalScrollIndicator = false
    
    // Set background color behind scroll views and for menu scroll view
    view.backgroundColor = settings.viewBackgroundColor
    menuScrollView.backgroundColor = settings.scrollMenuBackgroundColor
  }
  
  func setupBottomHairLine(settings:RATabMenuSettings,view:UIView){
    let menuBottomHairline : UIView = UIView()
    
    menuBottomHairline.translatesAutoresizingMaskIntoConstraints = false
    
    view.addSubview(menuBottomHairline)
    
    let menuBottomHairline_constraint_H:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|[menuBottomHairline]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["menuBottomHairline":menuBottomHairline])
    let menuBottomHairline_constraint_V:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|-\(settings.menuHeight)-[menuBottomHairline(0.5)]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["menuBottomHairline":menuBottomHairline])
    
    view.addConstraints(menuBottomHairline_constraint_H)
    view.addConstraints(menuBottomHairline_constraint_V)
    
    menuBottomHairline.backgroundColor = settings.bottomMenuHairlineColor
  }
  
  func setupControllerScrollView(controllerScrollView:UIScrollView,view:UIView,settings:RATabMenuSettings){
    
    // Set up controller scroll view
    controllerScrollView.pagingEnabled = true
    controllerScrollView.translatesAutoresizingMaskIntoConstraints = false
    controllerScrollView.alwaysBounceHorizontal = settings.enableHorizontalBounce
    controllerScrollView.bounces = settings.enableHorizontalBounce
    
    controllerScrollView.frame = CGRectMake(0.0, settings.menuHeight, view.frame.width, view.frame.height)
    
    view.addSubview(controllerScrollView)
    
  }
  
  func addControllerScrollViewConstraints(viewsDictionary:[String:UIView],view:UIView){
    let controllerScrollView_constraint_H:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|[controllerScrollView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewsDictionary)
    let controllerScrollView_constraint_V:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:|[controllerScrollView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewsDictionary)
    
    view.addConstraints(controllerScrollView_constraint_H)
    view.addConstraints(controllerScrollView_constraint_V)
    
  }
  
  func setupMenuScrollView(menuScrollView:UIScrollView,settings:RATabMenuSettings,view:UIView){
    menuScrollView.translatesAutoresizingMaskIntoConstraints = false
    
    menuScrollView.frame = CGRectMake(0.0, 0.0, view.frame.width, settings.menuHeight)
    
    view.addSubview(menuScrollView)
  }
  
  
  func addMenuScrollViewConstraints(viewsDictionary:[String:UIView],settings:RATabMenuSettings,view:UIView){
    let menuScrollView_constraint_H:Array = NSLayoutConstraint.constraintsWithVisualFormat("H:|[menuScrollView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewsDictionary)
    let menuScrollView_constraint_V:Array = NSLayoutConstraint.constraintsWithVisualFormat("V:[menuScrollView(\(settings.menuHeight))]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewsDictionary)
    
    view.addConstraints(menuScrollView_constraint_H)
    view.addConstraints(menuScrollView_constraint_V)
    
  }
}
