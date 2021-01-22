//
//  ContentView.swift
//  SwiftUICoffeeOrder
//
//  Created by Varun Tandon on 21/01/21.
//

import SwiftUI

struct ContentView: View {
    
  @ObservedObject private var orderListVM = OrderListViewModel()
  @State private var showModal = false
  
  var body: some View {
    NavigationView {
      OrderListView(orders: self.orderListVM.orders)
      
        .navigationBarTitle("Coffee Orders")
        .navigationBarItems(leading: Button(action: reloadOrders) {
          Image(systemName: "arrow.clockwise")
            .foregroundColor(.white)
        }, trailing: Button(action: showAddCoffeeOrderView) {
          Image(systemName: "plus")
            .foregroundColor(.white)
        })
        
        .sheet(isPresented: self.$showModal) {
          AddCoffeeOrderView(isPresented: self.$showModal)
        }
    }
  }
  
  private func reloadOrders() {
    self.orderListVM.fetchOrders()
  }
  
  private func showAddCoffeeOrderView() {
    self.showModal = true
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
