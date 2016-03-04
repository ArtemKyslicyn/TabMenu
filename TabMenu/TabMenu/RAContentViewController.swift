//
//  RAContentViewController.swift
//  TabMenu
//
//  Created by Arcilite on 04.03.16.
//  Copyright © 2016 Arcilite. All rights reserved.
//

import UIKit

public class RAContentViewController: UIViewController {
  var contentViewController:UIViewController!
  
  func setContentController(contentViewController:UIViewController?){
    if self.contentViewController == contentViewController{
      return;
    }
    
    contentViewController?.willMoveToParentViewController(nil)
    if let contentViewController = contentViewController{
        self.addChildViewController(contentViewController)
      
        if self.isViewLoaded(){
          if contentViewController.view.superview == self.view{
            contentViewController.view.removeFromSuperview()
          }else{
            
            self.view.addSubview(contentViewController.view)
          }
          self.didMoveToParentViewController(self)
          self.contentViewController = contentViewController
        }
    }
    
    
  
  }
 
}