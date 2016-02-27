//
//  RAScrollViewHandler.swift
//  TabMenu
//
//  Created by Arcilite on 26.02.16.
//  Copyright © 2016 Arcilite. All rights reserved.
//

import UIKit

class RAScrollViewHandler: NSObject,UIScrollViewDelegate {

//  public func scrollViewDidScroll(scrollView: UIScrollView) {
//    if !didLayoutSubviewsAfterRotation {
//      if scrollView.isEqual(controllerScrollView) {
//        if scrollView.contentOffset.x >= 0.0 && scrollView.contentOffset.x <= (CGFloat(controllerArray.count - 1) * self.view.frame.width) {
//          if (currentOrientationIsPortrait && UIApplication.sharedApplication().statusBarOrientation.isPortrait) || (!currentOrientationIsPortrait && UIApplication.sharedApplication().statusBarOrientation.isLandscape) {
//            // Check if scroll direction changed
//            if !didTapMenuItemToScroll {
//              if didScrollAlready {
//                var newScrollDirection : CAPSPageMenuScrollDirection = .Other
//                
//                if (CGFloat(startingPageForScroll) * scrollView.frame.width > scrollView.contentOffset.x) {
//                  newScrollDirection = .Right
//                } else if (CGFloat(startingPageForScroll) * scrollView.frame.width < scrollView.contentOffset.x) {
//                  newScrollDirection = .Left
//                }
//                
//                if newScrollDirection != .Other {
//                  if lastScrollDirection != newScrollDirection {
//                    let index : Int = newScrollDirection == .Left ? currentPageIndex + 1 : currentPageIndex - 1
//                    
//                    if index >= 0 && index < controllerArray.count {
//                      // Check dictionary if page was already added
//                      if pagesAddedDictionary[index] != index {
//                        addPageAtIndex(index)
//                        pagesAddedDictionary[index] = index
//                      }
//                    }
//                  }
//                }
//                
//                lastScrollDirection = newScrollDirection
//              }
//              
//              if !didScrollAlready {
//                if (lastControllerScrollViewContentOffset > scrollView.contentOffset.x) {
//                  if currentPageIndex != controllerArray.count - 1 {
//                    // Add page to the left of current page
//                    let index : Int = currentPageIndex - 1
//                    
//                    if pagesAddedDictionary[index] != index && index < controllerArray.count && index >= 0 {
//                      addPageAtIndex(index)
//                      pagesAddedDictionary[index] = index
//                    }
//                    
//                    lastScrollDirection = .Right
//                  }
//                } else if (lastControllerScrollViewContentOffset < scrollView.contentOffset.x) {
//                  if currentPageIndex != 0 {
//                    // Add page to the right of current page
//                    let index : Int = currentPageIndex + 1
//                    
//                    if pagesAddedDictionary[index] != index && index < controllerArray.count && index >= 0 {
//                      addPageAtIndex(index)
//                      pagesAddedDictionary[index] = index
//                    }
//                    
//                    lastScrollDirection = .Left
//                  }
//                }
//                
//                didScrollAlready = true
//              }
//              
//              lastControllerScrollViewContentOffset = scrollView.contentOffset.x
//            }
//            
//            var ratio : CGFloat = 1.0
//            
//            
//            // Calculate ratio between scroll views
//            ratio = (menuScrollView.contentSize.width - self.view.frame.width) / (controllerScrollView.contentSize.width - self.view.frame.width)
//            
//            if menuScrollView.contentSize.width > self.view.frame.width {
//              var offset : CGPoint = menuScrollView.contentOffset
//              offset.x = controllerScrollView.contentOffset.x * ratio
//              menuScrollView.setContentOffset(offset, animated: false)
//            }
//            
//            // Calculate current page
//            let width : CGFloat = controllerScrollView.frame.size.width;
//            let page : Int = Int((controllerScrollView.contentOffset.x + (0.5 * width)) / width)
//            
//            // Update page if changed
//            if page != currentPageIndex {
//              lastPageIndex = currentPageIndex
//              currentPageIndex = page
//              
//              if pagesAddedDictionary[page] != page && page < controllerArray.count && page >= 0 {
//                addPageAtIndex(page)
//                pagesAddedDictionary[page] = page
//              }
//              
//              if !didTapMenuItemToScroll {
//                // Add last page to pages dictionary to make sure it gets removed after scrolling
//                if pagesAddedDictionary[lastPageIndex] != lastPageIndex {
//                  pagesAddedDictionary[lastPageIndex] = lastPageIndex
//                }
//                
//                // Make sure only up to 3 page views are in memory when fast scrolling, otherwise there should only be one in memory
//                let indexLeftTwo : Int = page - 2
//                if pagesAddedDictionary[indexLeftTwo] == indexLeftTwo {
//                  pagesAddedDictionary.removeValueForKey(indexLeftTwo)
//                  removePageAtIndex(indexLeftTwo)
//                }
//                let indexRightTwo : Int = page + 2
//                if pagesAddedDictionary[indexRightTwo] == indexRightTwo {
//                  pagesAddedDictionary.removeValueForKey(indexRightTwo)
//                  removePageAtIndex(indexRightTwo)
//                }
//              }
//            }
//            
//            // Move selection indicator view when swiping
//            moveSelectionIndicator(page)
//          }
//        } else {
//          var ratio : CGFloat = 1.0
//          
//          ratio = (menuScrollView.contentSize.width - self.view.frame.width) / (controllerScrollView.contentSize.width - self.view.frame.width)
//          
//          if menuScrollView.contentSize.width > self.view.frame.width {
//            var offset : CGPoint = menuScrollView.contentOffset
//            offset.x = controllerScrollView.contentOffset.x * ratio
//            menuScrollView.setContentOffset(offset, animated: false)
//          }
//        }
//      }
//    } else {
//      didLayoutSubviewsAfterRotation = false
//      
//      // Move selection indicator view when swiping
//      moveSelectionIndicator(currentPageIndex)
//    }
//  }
//  
//  public func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
//    if scrollView.isEqual(controllerScrollView) {
//      // Call didMoveToPage delegate function
//      let currentController = controllerArray[currentPageIndex]
//      delegate?.didMoveToPage?(currentController, index: currentPageIndex)
//      
//      // Remove all but current page after decelerating
//      for key in pagesAddedDictionary.keys {
//        if key != currentPageIndex {
//          removePageAtIndex(key)
//        }
//      }
//      
//      didScrollAlready = false
//      startingPageForScroll = currentPageIndex
//      
//      
//      // Empty out pages in dictionary
//      pagesAddedDictionary.removeAll(keepCapacity: false)
//    }
//  }
  
}
