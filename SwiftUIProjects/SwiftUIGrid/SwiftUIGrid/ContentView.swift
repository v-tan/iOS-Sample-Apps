//
//  ContentView.swift
//  SwiftUIGrid
//
//  Created by Varun Tandon on 15/01/21.
//

import SwiftUI

struct ContentView: View {
  
  let animals = [["🐆", "🐇"], ["🦧", "🐿"], ["🦒", "🐕"], ["🐈", "🦘"]]
  
  var body: some View {
    
    NavigationView {
      VStack {
        List(self.animals, id: \.self) { animalPair in
          ForEach(animalPair, id: \.self) { animal in
            Text(animal)
              .font(.system(size: 100))
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
