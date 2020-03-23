//
//  EmojiCollectionViewDelegate.swift
//  EmojiLibrary
//
//  Created by Simone Tissi on 23/03/2020.
//  Copyright © 2020 Ray Wenderlich. All rights reserved.
//

import UIKit

class EmojiColletionViewDelegate: NSObject, UICollectionViewDelegateFlowLayout{
  let numberOfItemsPerRow: CGFloat
  let interItemSpacing: CGFloat
  weak var viewController: UIViewController?
  
  init(numberOfItemsPerRow: CGFloat, interItemSpacing: CGFloat){
    self.interItemSpacing = interItemSpacing
    self.numberOfItemsPerRow = numberOfItemsPerRow
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let maxWidth = UIScreen.main.bounds.width
    let totalSpacing = interItemSpacing * numberOfItemsPerRow
    let itemWidth = (maxWidth - totalSpacing)/numberOfItemsPerRow
    return CGSize(width: itemWidth, height: itemWidth)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return interItemSpacing
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    if section == 0 {
      return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }else{
      return UIEdgeInsets(top: interItemSpacing/2, left: 0, bottom: interItemSpacing/2, right: 0)
    }
  }

}
