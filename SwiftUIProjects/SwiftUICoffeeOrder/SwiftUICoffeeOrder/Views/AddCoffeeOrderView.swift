//
//  AddCoffeeOrderView.swift
//  SwiftUICoffeeOrder
//
//  Created by Varun Tandon on 23/01/21.
//

import SwiftUI

struct AddCoffeeOrderView: View {
  
  @ObservedObject private var addCoffeeOrderVM = AddCoffeeOrderViewModel()
  @Binding var isPresented: Bool
  
  var body: some View {
    NavigationView {
      
      VStack {
        
        Form {
          
          Section(header: Text("INFORMATION").font(.body)) {
            TextField("Enter your name", text: self.$addCoffeeOrderVM.name)
          }
          
          Section(header: Text("SELECT COFFEE").font(.body)) {
            ForEach(addCoffeeOrderVM.coffeeList, id: \.name) { coffee in
              
              CoffeeCellView(coffee: coffee, selection: self.$addCoffeeOrderVM.coffeeName)
            }
          }
          
          Section(header: Text("SELECT SIZE").font(.body), footer: OrderTotalView(total: self.addCoffeeOrderVM.total)) {
            Picker("", selection: self.$addCoffeeOrderVM.size) {
              Text("Small")
                .tag("Small")
              
              Text("Medium")
                .tag("Medium")
              
              Text("Large")
                .tag("Large")
            }.pickerStyle(SegmentedPickerStyle())
          }
          
        }
        
        HStack {
          Button("Place Order") {
            self.addCoffeeOrderVM.placeOrder()
            self.isPresented = false
            
          }.padding(EdgeInsets(top: 12, leading: 100, bottom: 12, trailing: 100))
          .foregroundColor(.white)
          .background(Color(red: 46/255, green: 204/255, blue: 113/255))
          .cornerRadius(10)
        }
      }
      
      .navigationBarTitle("Add Order")
    }
  }
}

#if DEBUG
struct AddCoffeeOrderView_Previews: PreviewProvider {
  static var previews: some View {
    AddCoffeeOrderView(isPresented: .constant(false))
  }
}
#endif



//MARK: - Coffee Cell
struct CoffeeCellView: View {
  let coffee: CoffeeViewModel
  @Binding var selection: String
  
  var body: some View {
    HStack {
      Image(coffee.imageURL)
        .resizable()
        .frame(width: 100, height: 100)
        .cornerRadius(16)
      
      Text(coffee.name)
        .font(.title)
        .padding([.leading], 20)
      
      Spacer()
      
      Image(systemName: self.selection == self.coffee.name ? "checkmark" : "")
    }.onTapGesture {
      self.selection = self.coffee.name
    }
  }
}
