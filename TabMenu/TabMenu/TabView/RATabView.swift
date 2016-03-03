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
  
  var collectionView :UICollectionView!
  var collectionViewLayout =  RATabCollectionViewLayout()
  var titles:[String]
  var delegate : RATabViewDelegate?
  
  init(frame:CGRect, titles:[String]) {
    self.titles = titles
    super.init(frame:frame)
    
    self.backgroundColor = tabColor
    collectionView = UICollectionView(frame:self.bounds, collectionViewLayout: collectionViewLayout)
    collectionView.dataSource = self
    collectionView.delegate = self
    collectionView.contentInset = UIEdgeInsetsMake(0, frame.width/2, 0, frame.width/2)
    collectionView.backgroundColor = UIColor.clearColor()
    self.addSubview(collectionView)
    self.configureCollectionView()
  
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
  

  func selectTab(sender:UIButton){
      delegate?.selectedTabIndex(sender.tag)
  }
  
  func selectedTabIndex(index:Int){
   
    let indexPath =  NSIndexPath(forItem: index, inSection: 0)
    print("selected \(indexPath.row)")
   
    
    let attr = self.collectionView.collectionViewLayout.layoutAttributesForItemAtIndexPath(indexPath)

    if let cellRect = attr?.frame{
      
      let offset = CGPointMake(cellRect.origin.x+cellRect.size.width/2 - self.frame.width/2,0  );
      self.collectionView.setContentOffset(offset, animated: true)
    }
 
 
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
    return cell
  }
  
   func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
    
    print("INDEX  PAGES SELECTED \(indexPath.row)")
    delegate?.selectedTabIndex(indexPath.row)
    
   }
  

}

extension RATabView: UICollectionViewDelegateFlowLayout {
  
  func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
     let title = self.titles[indexPath.row]
     let textSize = title.widthWithConstrainedWidth(50, font: titleTabFont)
     return CGSizeMake(textSize.width+10, textSize.height)
  }

}

extension String {
  func widthWithConstrainedWidth(height:CGFloat, font: UIFont) -> CGSize {
    let constraintRect = CGSize(width: CGFloat.max, height:height)
    
    let boundingBox = self.boundingRectWithSize(constraintRect, options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: [NSFontAttributeName: font], context: nil)
    
    return CGSizeMake(boundingBox.width, height)
  }
}
