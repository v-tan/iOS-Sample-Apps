//
//  LandmarkList.swift
//  Landmarks
//
//  Created by Varun Tandon on 25/04/21.
//

import SwiftUI

struct LandmarkList: View {
  @State private var showFavoritesOnly = false
  
  var filteredLandmarks: [Landmark] {
    landmarks.filter { landmark in
      !showFavoritesOnly || landmark.isFavorite
    }
  }
  
  var body: some View {
    
    NavigationView {
      List {
        Toggle(isOn: $showFavoritesOnly) {
          Text("Favorites Only")
        }
        
        ForEach(filteredLandmarks) { landmark in
          NavigationLink(destination: LandmarkDetail(landmark: landmark)) {
            LandmarkRow(landmark: landmark)
          }
        }
        
        .navigationTitle("Landmarks")
      }
    }
  }
  
}

struct LandmarkList_Previews: PreviewProvider {
  static var previews: some View {
    LandmarkList()
  }
}
