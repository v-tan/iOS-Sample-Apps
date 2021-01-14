//
//  TravelDestination.swift
//  Destinations
//
//  Created by Varun Tandon on 14/01/21.
//

import Foundation

struct TravelDestination {
  let name: String
  let imageURL: String
  let touristAttractions: [String]
}

extension TravelDestination {
  
  static func mockData() -> [TravelDestination] {
    return [
      TravelDestination(name: "Goa", imageURL: "goa", touristAttractions: ["Dudhsagar Falls, Aguada Fort, Palolem Beach"]),
      TravelDestination(name: "Kerela", imageURL: "kerela", touristAttractions: ["Wayanad, Thekkady, Munnar"]),
      TravelDestination(name: "Kashmir", imageURL: "kashmir", touristAttractions: ["Pehelgam, Kargil, Gulmarg"])
    ]
  }
}

