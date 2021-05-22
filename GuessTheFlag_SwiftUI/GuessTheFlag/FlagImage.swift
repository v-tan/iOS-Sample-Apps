//
//  FlagImage.swift
//  GuessTheFlag
//
//  Created by Varun Tandon on 22/05/21.
//

import SwiftUI

struct FlagImage: View {
  let country: String
  
  var body: some View {
    Image(country)
      .renderingMode(.original)
      .clipShape(Capsule())
      .overlay(Capsule().stroke(Color.black, lineWidth: 1))
      .shadow(color: .black, radius: 2)
  }
}

struct FlagImage_Previews: PreviewProvider {
  static var previews: some View {
    FlagImage(country: "Estonia")
  }
}
