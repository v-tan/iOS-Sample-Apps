//
//  ContentView.swift
//  SwiftUIGrid
//
//  Created by Varun Tandon on 15/01/21.
//

import SwiftUI

struct ContentView: View {
  
  let animals = ["🐆", "🐇", "🦧", "🐿", "🦒", "🐕", "🐈", "🦘"]
  @State private var sliderValue: CGFloat = 1
  
  var body: some View {
    
    NavigationView {
      
      VStack {
        
        Slider(value: $sliderValue, in: 1...8, step: 1)
        Text(String(format: "%.0f", self.sliderValue))
          .font(.system(size: 20))
          .fontWeight(.bold)
          .padding()
          .background(Color.purple)
          .foregroundColor(.white)
          .clipShape(Circle())
        
        List(self.animals.chunked(into: Int(sliderValue)), id: \.self) { chunk in
          ForEach(chunk, id: \.self) { animal in
            Text(animal)
              .font(.system(size: CGFloat(300/sliderValue)))
          }
        }
      }
      
      .navigationBarTitle(Text("Animals"))
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
