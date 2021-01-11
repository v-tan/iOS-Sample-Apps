//
//  ContentView.swift
//  Hello-SwiftUI
//
//  Created by Varun Tandon on 11/01/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
      
      VStack {
        Image("old_man_and_house")
          .resizable()
          .aspectRatio(contentMode: .fit)
          .cornerRadius(50)
          .padding(.all)
//          .clipShape(Circle())
        
        Text("First Line")
          .foregroundColor(.green)
          .font(.largeTitle)
        
        Text("Second Line")
          .foregroundColor(.orange)
          .font(.title)
        
        HStack {
          Text("Left Side")
          Text("Right Side")
            .padding(.all)
        }
      }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
