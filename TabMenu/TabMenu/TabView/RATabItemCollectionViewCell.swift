//
//  RATabItemCollectionViewCell.swift
//  TabMenu
//
//  Created by Arcilite on 02.03.16.
//  Copyright © 2016 Arcilite. All rights reserved.
//

import UIKit

class RATabItemCollectionViewCell: UICollectionViewCell {
  var titleLabel: UILabel!

 override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
  }
  
  
  override init(frame: CGRect) {
    super.init(frame: frame)
   
    titleLabel = UILabel(frame: CGRectMake(5,0,frame.size.width-5,frame.size.height))
    titleLabel.textAlignment = NSTextAlignment.Center
    titleLabel.font = titleTabFont
    titleLabel.backgroundColor = UIColor.greenColor()
//    contentView.addConstraints([
//      createConstraint(titleLabel, toItem: contentView, attribute: .Top),
//      createConstraint(titleLabel, toItem: contentView, attribute: .Bottom),
//      createConstraint(titleLabel, toItem: contentView, attribute: .Left),
//      createConstraint(titleLabel, toItem: contentView, attribute: .Right),
//      ])
    
    contentView.addSubview(titleLabel)
    
    
  }

  
  private func createConstraint(item: UILabel, toItem: UIView, attribute: NSLayoutAttribute) -> NSLayoutConstraint {
    return NSLayoutConstraint(item: item,
      attribute: attribute,
      relatedBy: .Equal,
      toItem: toItem,
      attribute: attribute,
      multiplier: 1,
      constant: 0)
  }
  
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  internal override func prepareForReuse() {
    super.prepareForReuse()
    //titleLabel.sizeToFit()
  }


}
