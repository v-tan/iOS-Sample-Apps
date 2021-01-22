//
//  CoffeeListViewModel.swift
//  SwiftUICoffeeOrder
//
//  Created by Varun Tandon on 23/01/21.
//

import Foundation

struct CoffeeListViewModel {
  var coffeeList = [CoffeeViewModel]()
}

struct CoffeeViewModel {
  
  var coffee: Coffee
  
  init(coffee: Coffee) {
    self.coffee = coffee
  }
  
  var name: String {
    return self.coffee.name
  }
  
  var imageURL: String {
    return self.coffee.imageURL
  }
  
  var price: Double {
    return self.coffee.price
  }
}
