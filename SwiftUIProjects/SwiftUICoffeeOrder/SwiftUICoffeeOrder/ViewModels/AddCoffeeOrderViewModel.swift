//
//  AddCoffeeOrderViewModel.swift
//  SwiftUICoffeeOrder
//
//  Created by Varun Tandon on 22/01/21.
//

import Foundation
import Combine

class AddCoffeeOrderViewModel: ObservableObject {
    
  private var webService: Webservice
  @Published var name = ""
  @Published var size = "Medium"
  @Published var coffeeName = ""
  
  init() {
    webService = Webservice()
  }
  
  var coffeeList: [CoffeeViewModel] {
    return Coffee.all().map(CoffeeViewModel.init)
  }
  
  var total: Double {
    calculateTotalPrice()
  }
  
  func placeOrder() {
    let order = Order(name: self.name, size: self.size, coffeeName: self.coffeeName, total: self.total)
    
    webService.createCoffeeOrder(order: order) { response in
      
    }
  }
  
  private func priceForSize() -> Double {
    let prices = ["Small": 2.0, "Medium": 3.0, "Large": 4.0]
    return prices[self.size]!
  }
  
  private func calculateTotalPrice() -> Double {
    let coffeeVM = coffeeList.first { $0.name == coffeeName}
    if let coffeeVM = coffeeVM {
      return coffeeVM.price * priceForSize()
    } else {
      return 0.0
    }
  }
}
