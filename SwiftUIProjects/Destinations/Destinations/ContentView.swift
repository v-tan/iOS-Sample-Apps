//
//  ContentView.swift
//  Destinations
//
//  Created by Varun Tandon on 14/01/21.
//

import SwiftUI

struct ContentView: View {
  let destinations = TravelDestination.mockData()
  
  var body: some View {
    GeometryReader { metrics in
      NavigationView {
        
        List(self.destinations, id: \.name) { destination in
          NavigationLink(
            destination: DestinationDetailView(destination: destination)
          ) {
            DestinationCell(destination: destination, screenWidth: metrics.size.width)
          }
        }
        .navigationBarTitle("Destinations")
        
      }
    }
  }
  
}


#if DEBUG
struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
#endif


struct DestinationCell: View {
  let destination: TravelDestination
  let screenWidth: CGFloat
  
  var body: some View {
    HStack {
      Image(destination.imageURL)
        .resizable()
        .cornerRadius(20)
        .frame(
          width: screenWidth * 0.4,
          height: screenWidth * 0.3,
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

