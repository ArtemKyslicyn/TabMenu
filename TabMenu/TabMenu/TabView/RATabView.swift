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

class RATabView: UIView, UICollectionViewDelegate, UICollectionViewDataSource {

 // let menuScrollView = UIScrollView()
  var collectionView :UICollectionView!
  var collectionViewLayout =  RATabCollectionViewLayout()
  var buttons = [RATabItem]()
  var titles:[String]
  var delegate : RATabViewDelegate?
  
  init(frame:CGRect, titles:[String]) {
    self.titles = titles
    super.init(frame:frame)
    
    self.backgroundColor = tabColor
    //collectionViewLayout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
    //collectionViewLayout.itemSize = CGSize(width: 90, height: 120)
    collectionView = UICollectionView(frame:self.bounds, collectionViewLayout: collectionViewLayout)
    collectionView.dataSource = self
    collectionView.delegate = self
    collectionView.contentInset = UIEdgeInsetsMake(0, frame.width/2, 0, frame.width/2)
    collectionView.backgroundColor = UIColor.clearColor()
    self.addSubview(collectionView)
    self.configureCollectionView()
   
    //collectionView.sc
   // SetScrollViewContentInsets
//    menuScrollView.frame.size = frame.size
//    menuScrollView.backgroundColor = tabColor
//    self.addSubview(menuScrollView)
//    self.setupViewWithFrame(frame, titlesArray: titles)
    self.collectionView.reloadData()
  }

   func configureCollectionView() {
    
    collectionViewLayout.scrollDirection = .Horizontal
    collectionViewLayout.minimumInteritemSpacing = 0;

    collectionView?.showsHorizontalScrollIndicator = false
    collectionView?.registerClass(RATabItemCollectionViewCell.self, forCellWithReuseIdentifier: String(RATabItemCollectionViewCell))
  }

  required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
  }
  
//  func setupViewWithFrame(frame:CGRect,titlesArray:[String]){
//    var contentOffset:CGFloat = self.frame.width/2
//    for (index,title) in titlesArray.enumerate() {
//      let button = RATabItem(frame:CGRectMake(contentOffset, 0, 0, frame.size.height), title:title)
//      //button.backgroundColor = UIColor.orangeColor()
//      //
//      contentOffset +=  button.intrinsicContentSize().width
//      button.frame.size.width = button.intrinsicContentSize().width
//      button.tag = index
//      button.backgroundColor = UIColor.orangeColor()
//      button.addTarget(self, action: "selectTab:", forControlEvents: UIControlEvents.TouchUpInside)
//      buttons.append(button)
//      menuScrollView.addSubview(button)
//    }
//    menuScrollView.contentSize = CGSizeMake(contentOffset + self.frame.width/2
//, tabHeight)
//     self.setNeedsLayout()
//  }
//  
  func selectTab(sender:UIButton){
      delegate?.selectedTabIndex(sender.tag)
  }
  
  func selectedTabIndex(index:Int){
    let indexPath =  NSIndexPath(forItem: index, inSection: 0)
    print(index)
    collectionView.scrollToItemAtIndexPath(indexPath, atScrollPosition: UICollectionViewScrollPosition.CenteredHorizontally, animated: true)
   //let button = buttons[index]
   // let newContentOffsetX :CGFloat = (menuScrollView.contentSize.width/2) - (menuScrollView.bounds.size.width/2);
   // let centerButton = button.center
//    var xofsset = menuScrollView.contentSize.width - button.frame.origin.x - button.frame.size.width
//    if xofsset > menuScrollView.contentSize.width{
//      //xofsset = centerButton
//       xofsset = menuScrollView.contentSize.width/2
//    }else{
//     xofsset = 50
//    }
// 
   // if center.x < menuScrollView.contentSize.width{
//   let offset =   (menuScrollView.contentSize.width  / CGFloat(buttons.count) ) *  CGFloat(index) - 100
//   let point = CGPointMake(offset, 0)
//
//    
//    UIView.animateWithDuration(0.2, delay: 0.2, options:  .CurveEaseInOut, animations: {
//        self.menuScrollView.setContentOffset(point, animated: true)
//    }, completion: nil)
    
 
  }
  
  func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return titles.count
  }
  
   func collectionView(collectionView: UICollectionView,
    willDisplayCell cell: UICollectionViewCell,
    forItemAtIndexPath indexPath: NSIndexPath) {
      
    //  cell.
      if let cell = cell as? RATabItemCollectionViewCell {
        cell.titleLabel.text = titles[indexPath.row]
        cell.backgroundColor = UIColor.redColor()
    }
  }
  
   func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCellWithReuseIdentifier(String(RATabItemCollectionViewCell), forIndexPath: indexPath)
    cell.backgroundColor = UIColor.yellowColor()
    return cell
  }
  
   func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
      delegate?.selectedTabIndex(indexPath.row)
   }
  

}

extension RATabView: UICollectionViewDelegateFlowLayout {
  
  func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
    let title = self.titles[indexPath.row]
     let textSize = title.widthWithConstrainedWidth(50, font: titleTabFont)

     return CGSizeMake(textSize.width + 10, textSize.height)
  }
  
  func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: NSInteger) -> CGFloat {
    return 0
  }
  
//  func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: NSInteger) -> CGFloat {
//    return 0
//  }
//  
  
}


extension String {
  func widthWithConstrainedWidth(height:CGFloat, font: UIFont) -> CGSize {
    let constraintRect = CGSize(width: CGFloat.max, height:height)
    
    let boundingBox = self.boundingRectWithSize(constraintRect, options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: [NSFontAttributeName: font], context: nil)
    
    return CGSizeMake(boundingBox.width, height)
  }
}
