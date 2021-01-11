//
//  ContentView.swift
//  Hiking
//
//  Created by Varun Tandon on 11/01/21.
//

import SwiftUI

struct ContentView: View {
  
  let destinations = TravelDestination.mockData()
  
  var body: some View {
    GeometryReader { metrics in
      
      List(self.destinations, id: \.name) { destination in
        HStack {
          Image(destination.imageURL)
            .resizable()
            .cornerRadius(20)
            .frame(
              width: metrics.size.width * 0.4,
              height: metrics.size.width * 0.3,
              alignment: .leading)
          
          VStack(alignment: .leading) {
            Text(destination.name)
              .font(.title)
              .frame(alignment: .topLeading)
            
            Text(destination.touristAttractions.joined())
              .foregroundColor(.blue)
          }
        }
      }
    }
    
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
