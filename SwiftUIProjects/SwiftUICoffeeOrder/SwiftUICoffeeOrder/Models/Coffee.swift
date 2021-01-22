//
//  Coffee.swift
//  SwiftUICoffeeOrder
//
//  Created by Varun Tandon on 21/01/21.
//

import Foundation

struct Coffee {
  let name: String
  let imageURL: String
  let price: Double
}

extension Coffee {
  static func all() -> [Coffee] {
    return [
      Coffee(name: "Espresso", imageURL: "Espresso", price: 2.5),
      Coffee(name: "Cappucino", imageURL: "Cappuccino", price: 2.5),
      Coffee(name: "Regular", imageURL: "Regular", price: 1.0)
    ]
  }
}
