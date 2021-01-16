//
//  Array+Extensions.swift
//  SwiftUIGrid
//
//  Created by Varun Tandon on 17/01/21.
//

import Foundation

extension Array {
  
  func chunked(into size: Int) -> [ArraySlice<Element>] {
    var chunks = [ArraySlice<Element>]()
    
    for index in stride(from: 0, to: self.count - 1, by: size) {
      
      var chunk = ArraySlice<Element>()
      let end = index + size
      if end >= self.count {
        chunk = self[index..<self.count]
      } else {
        chunk = self[index..<end]
      }
      
      chunks.append(chunk)
      
      if (end + 1) == self.count {
        let remainingChunk = self[end..<self.count]
        chunks.append(remainingChunk)
      }
    }
    
    return chunks
  }
}
