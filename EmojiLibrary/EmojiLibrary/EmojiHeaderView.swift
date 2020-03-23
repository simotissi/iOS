//
//  EmojiHeaderView.swift
//  EmojiLibrary
//
//  Created by Simone Tissi on 23/03/2020.
//  Copyright © 2020 Ray Wenderlich. All rights reserved.
//

import UIKit

class EmojiHeaderView: UICollectionReusableView{
  static let reuseIdentifier = String(describing: EmojiHeaderView.self)
  
  @IBOutlet weak var textLabel: UILabel!
}
