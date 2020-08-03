//
//  ChecklistItem.swift
//  checklists
//
//  Created by Varun Tandon on 02/08/20.
//  Copyright © 2020 Varun Tandon. All rights reserved.
//

import Foundation

class ChecklistItem : NSObject, Codable {
  var text: String
  var checked: Bool
  
  override init() {
    text = ""
    checked = false
    super.init()
  }
  
  func toggleChecked() {
    checked.toggle()
  }
}
