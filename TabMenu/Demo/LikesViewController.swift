//
//  LikesViewController.swift
//  TabMenu
//
//  Created by Arcilite on 24.02.16.
//  Copyright © 2016 Arcilite. All rights reserved.
//

import UIKit

class LikesViewController: UITableViewController {
    var allArray = [FeedItemAppearance]()
  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.tableView.registerNib(UINib(nibName: "LikeTableViewCell", bundle: nil), forCellReuseIdentifier: "LikeTableViewCell")
    self.view.backgroundColor = UIColor.greenColor()
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    
    print("Likes page: viewWillAppear")
  }
  
  override func viewDidAppear(animated: Bool) {
    self.tableView.showsVerticalScrollIndicator = false
    super.viewDidAppear(animated)
    self.tableView.showsVerticalScrollIndicator = true
    
    //        println("favorites page: viewDidAppear")
  }
  
  
  // MARK: - Table view data source
  
  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    // #warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1
  }
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // #warning Incomplete method implementation.
    // Return the number of rows in the section.
    return allArray.count
  }
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell : LikeTableViewCell = tableView.dequeueReusableCellWithIdentifier("LikeTableViewCell") as! LikeTableViewCell
    
    // Configure the cell...
    // cell.nameLabel.text = allArray[indexPath.row]
    //cell.photoImageView.image = UIImage(named: photoNameArray[indexPath.row])
    
    return cell
  }
  
  override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    return 94.0
  }
  
  override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    return 0.001
  }
}
