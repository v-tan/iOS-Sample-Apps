//
//  Checklist.swift
//  checklists
//
//  Created by Varun Tandon on 06/08/20.
//  Copyright © 2020 Varun Tandon. All rights reserved.
//

import UIKit

class Checklist: NSObject, Codable {
  var name = ""
  var items = [ChecklistItem]()
  
  init(name: String) {
    self.name = name
    super.init()
  }
}
