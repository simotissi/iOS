//
//  NumberCell.swift
//  FirstCollectionView
//
//  Created by Simone Tissi on 23/03/2020.
//  Copyright © 2020 Simone Tissi. All rights reserved.
//

import UIKit

class NumberCell: UICollectionViewCell {
  static let reuseId = String(describing: NumberCell.self)
  
  @IBOutlet weak var label: UILabel!
}
