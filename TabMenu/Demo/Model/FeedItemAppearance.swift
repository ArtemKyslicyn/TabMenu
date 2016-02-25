//
//  FeedItem.swift
//  TabMenu
//
//  Created by Arcilite on 25.02.16.
//  Copyright © 2016 Arcilite. All rights reserved.
//

import Foundation

enum FeedType{
  case FollowType(User)
  case ComentType(Comment)
  case LikeType(Like)
}

class FeedItemAppearance {
  var type:FeedType!
}