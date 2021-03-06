//
//  ViewController.swift
//  Project2
//
//  Created by Varun Tandon on 31/03/20.
//  Copyright © 2020 Varun Tandon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet var button1: UIButton!
  @IBOutlet var button2: UIButton!
  @IBOutlet var button3: UIButton!
  
  var countries = [String]()
  var questionsAsked = 0
  var score = 0
  var correctAnswer = 0
  
  override func viewDidLoad() {
    super.viewDidLoad()

    button1.layer.borderWidth = 1
    button2.layer.borderWidth = 1
    button3.layer.borderWidth = 1
    
    button1.layer.borderColor = UIColor.lightGray.cgColor
    button2.layer.borderColor = UIColor.lightGray.cgColor
    button3.layer.borderColor = UIColor.lightGray.cgColor
    
    countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
    
    askQuestion()
  }
  
  func askQuestion(action: UIAlertAction! = nil) {
    if questionsAsked == 10 {
      let ac = UIAlertController(title: nil, message: "Your Final Score is \(score)",
      preferredStyle: .alert)
      ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
      present(ac, animated: true)
      return
    }
    
    questionsAsked += 1
    countries.shuffle()
    
    button1.setImage(UIImage(named: countries[0]), for: .normal)
    button2.setImage(UIImage(named: countries[1]), for: .normal)
    button3.setImage(UIImage(named: countries[2]), for: .normal)
    
    correctAnswer = Int.random(in: 0...2)
    title = countries[correctAnswer].uppercased()
  }
  
  @IBAction func buttonTapped(_ sender: UIButton) {
    var title: String
    
    if sender.tag == correctAnswer {
      title = "Correct"
      score += 1
    } else {
      title = """
              Wrong!
              That's the flag of \(countries[sender.tag].uppercased())
              """
      score -= 1
    }
    
    let ac = UIAlertController(title: title, message: "Your score is \(score)",
      preferredStyle: .alert)
    ac.addAction(UIAlertAction(title: "Continue", style: .default,
                               handler: askQuestion))
    present(ac, animated: true)
  }
  
  @IBAction func scoreTapped(_ sender: UIBarButtonItem) {
    let ac = UIAlertController(title: "Score", message: "Your score is \(score)",
      preferredStyle: .alert)
    ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
    present(ac, animated: true)
  }
}

