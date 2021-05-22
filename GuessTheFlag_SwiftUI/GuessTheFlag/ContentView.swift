//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Varun Tandon on 21/05/21.
//

import SwiftUI

struct ContentView: View {
  @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
  @State private var correctAnswer = Int.random(in: 0...2)
  
  @State private var showingScore = false
  @State private var scoreTitle = ""
  @State private var score = 0
  
  var body: some View {
    ZStack {
      LinearGradient(gradient: Gradient(colors: [Color.blue, Color.black]), startPoint: .top, endPoint: .bottom)
        .edgesIgnoringSafeArea(.all)
      
      VStack(spacing: 30) {
        VStack {
          Text("Tap the flag of")
          Text(countries[correctAnswer])
            .fontWeight(.black)
            .withLargeTitle()
        }
        .foregroundColor(.white)
        
        ForEach(0..<3) { number in
          Button(action: {
            self.flagTapped(number)
          }, label: {
            FlagImage(country: self.countries[number])
          })
        }
        
        Text("Score: \(score)")
          .foregroundColor(.white)
          .bold()
        
        Spacer()
      }
    }.alert(isPresented: $showingScore) {
      Alert(title: Text(scoreTitle), message: Text("Your Score is \(score)"), dismissButton: .default(Text("Continue")) {
        self.askQuestion()
      })
    }
  }
  
  func flagTapped(_ number: Int) {
    if number == correctAnswer {
      scoreTitle = "Correct!"
      score += 1
    } else {
      scoreTitle = "Wrong! That's the flag of \(self.countries[number])"
      score -= 1
    }
    
    self.showingScore = true
  }
  
  func askQuestion() {
      countries.shuffle()
      correctAnswer = Int.random(in: 0...2)
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}

struct CountryTitle: ViewModifier {
  func body(content: Content) -> some View {
      content
        .font(.largeTitle)
  }
}

extension View {
  func withLargeTitle() -> some View {
    return self.modifier(CountryTitle())
  }
}
