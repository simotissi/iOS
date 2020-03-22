//
//  ChecklistTableViewCell.swift
//  CheckList
//
//  Created by Simone Tissi on 21/03/2020.
//  Copyright © 2020 Simone Tissi. All rights reserved.
//

import UIKit

class ChecklistTableViewCell: UITableViewCell {
  
  @IBOutlet weak var todoTextLabel: UILabel!
  @IBOutlet weak var checkmarkLabel: UILabel!
  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
