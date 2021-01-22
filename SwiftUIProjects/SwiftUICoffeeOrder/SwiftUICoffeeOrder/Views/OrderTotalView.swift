//
//  OrderTotalView.swift
//  SwiftUICoffeeOrder
//
//  Created by Varun Tandon on 23/01/21.
//

import SwiftUI

struct OrderTotalView: View {
  
  let total: Double
  
  var body: some View {
    HStack(alignment: .center) {
      Spacer()
      
      Text(String(format: "$%0.2f", total)).font(.title)
        .foregroundColor(.green)
      
      Spacer()
    }.padding(10)
  }
}

struct OrderTotalView_Previews: PreviewProvider {
  static var previews: some View {
    OrderTotalView(total: 45.67)
  }
}
