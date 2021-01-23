//
//  ContentView.swift
//  SwiftUIGesturesDemo
//
//  Created by Varun Tandon on 24/01/21.
//

import SwiftUI

struct ContentView: View {
  
  @State private var tapped = false
  @State private var cardDragState = CGSize.zero
  @State private var cardRotateState: Double = 0
  
  var body: some View {
    Card(tapped: self.tapped)
      .animation(.spring())
      .rotationEffect(Angle(degrees: self.cardRotateState))
      .offset(y: self.cardDragState.height)
      .gesture(RotationGesture()
                .onChanged { value in
                  self.cardRotateState = value.degrees
                })
      .gesture(DragGesture()
                .onChanged { value in
                  self.cardDragState = value.translation
                }
                .onEnded { value in
                  self.cardDragState = CGSize.zero
                })
      .gesture(
        TapGesture(count: 1)
          .onEnded {
            self.tapped.toggle()
          })
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
