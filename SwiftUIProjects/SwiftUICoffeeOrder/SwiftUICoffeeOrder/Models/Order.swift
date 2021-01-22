//
//  Order.swift
//  SwiftUICoffeeOrder
//
//  Created by Varun Tandon on 21/01/21.
//

import Foundation

struct Order: Codable {
  let name: String
  let size: String
  let coffeeName: String
  let total: Double
}
