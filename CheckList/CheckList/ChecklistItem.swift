//
//  ChecklistItem.swift
//  CheckList
//
//  Created by Simone Tissi on 21/03/2020.
//  Copyright © 2020 Simone Tissi. All rights reserved.
//

import Foundation

class ChecklistItem: NSObject {
  @objc var text = ""
  var isChecked = false
  
  func toggleChecked(){
    isChecked = !isChecked
  }
}
