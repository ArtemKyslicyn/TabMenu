//
//  ViewController.swift
//  TabMenu
//
//  Created by Arcilite on 24.02.16.
//  Copyright © 2016 Arcilite. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
  
  var pageMenu : RATabMenu!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    
    var controllerArray : [UIViewController] = []

    let controller1  = storyboard.instantiateViewControllerWithIdentifier("AllViewController") as! AllViewController
    controller1.title = "All"
    controllerArray.append(controller1)
    let controller2  = storyboard.instantiateViewControllerWithIdentifier("LikesViewController") as! LikesViewController
    controller2.title = "Likes"
    controllerArray.append(controller2)
   
    let controller3 : FollowsViewController = storyboard.instantiateViewControllerWithIdentifier("FollowsViewController") as! FollowsViewController
    
    controller3.title = "Folows"
    controllerArray.append(controller3)
    let controller4 : CommentsViewController = storyboard.instantiateViewControllerWithIdentifier("CommentsViewController") as! CommentsViewController

    controller4.title = "Comments"
    controllerArray.append(controller4)
    
    
    // Do any additional setup after loading the view, typically from a nib.
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


}

