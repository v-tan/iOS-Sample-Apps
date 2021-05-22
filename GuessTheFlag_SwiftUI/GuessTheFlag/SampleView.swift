//
//  SampleView.swift
//  GuessTheFlag
//
//  Created by Varun Tandon on 22/05/21.
//

import SwiftUI

/// a sample view to show how custom binding works
struct SampleViewWithCustomBinding: View {
  @State var agreedToTerms = false
  @State var agreedToPrivacyPolicy = false
  @State var agreedToEmails = false
  
  var body: some View {
    let agreedToAll = Binding<Bool>(
      get: {
        self.agreedToTerms && self.agreedToPrivacyPolicy && self.agreedToEmails
      },
      set: {
        self.agreedToTerms = $0
        self.agreedToPrivacyPolicy = $0
        self.agreedToEmails = $0
      }
    )
    
    return VStack {
      Toggle(isOn: $agreedToTerms) {
        Text("Agree to terms")
      }
      
      Toggle(isOn: $agreedToPrivacyPolicy) {
        Text("Agree to privacy policy")
      }
      
      Toggle(isOn: $agreedToEmails) {
        Text("Agree to receive shipping emails")
      }
      
      Toggle(isOn: agreedToAll) {
        Text("Agree to all")
      }
    }
  }
}

struct SampleView_Previews: PreviewProvider {
  static var previews: some View {
    SampleViewWithCustomBinding()
  }
}
