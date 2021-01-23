//
//  Card.swift
//  SwiftUIGesturesDemo
//
//  Created by Varun Tandon on 24/01/21.
//

import SwiftUI

struct Card: View {
  let tapped: Bool
  @State private var scale: CGFloat = 1.0
  
  var body: some View {
    
    VStack {
      
      Image("cat")
        .resizable()
        .scaleEffect(self.scale)
        .gesture(MagnificationGesture()
                  .onChanged { value in
                    self.scale = value.magnitude
                  }
                  .onEnded { _ in
                    
                  })
        
        .frame(width: 300, height: 300)
      
      Text("Card")
        .font(.title)
        .foregroundColor(.white)
      
    }
    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
    .background(self.tapped ? Color.orange: Color.purple)
    .cornerRadius(30)
    
  }
}

struct Card_Previews: PreviewProvider {
  static var previews: some View {
    Card(tapped: false)
  }
}
