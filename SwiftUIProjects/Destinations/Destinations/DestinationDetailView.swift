//
//  DestinationDetailView.swift
//  Destinations
//
//  Created by Varun Tandon on 14/01/21.
//

import SwiftUI

struct DestinationDetailView: View {

  let destination: TravelDestination
  @State private var zoomed = false
  
  var body: some View {
    VStack {
      Image(destination.imageURL)
        .resizable()
        .aspectRatio(contentMode: self.zoomed ? .fill : .fit)
        .onTapGesture {
          withAnimation {
            self.zoomed.toggle()
          }
        }
      
      Text(destination.name)
      Text(destination.touristAttractions.joined())
    }.navigationBarTitle(Text(destination.name), displayMode: .inline)
    .navigationBarHidden(self.zoomed)
  }
}

#if DEBUG
struct DestinationDetailView_Previews: PreviewProvider {
  static var previews: some View {
    DestinationDetailView(destination: TravelDestination.mockData()[2])
  }
}
#endif
