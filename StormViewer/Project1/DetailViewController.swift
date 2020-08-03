//
//  DetailViewController.swift
//  Project1
//
//  Created by Varun Tandon on 31/03/20.
//  Copyright © 2020 Varun Tandon. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
  
  @IBOutlet var imageView: UIImageView!
  var selectedImage: String?
  var selectedImageNumber: Int?
  var totalImages: Int?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    title = "Picture \(selectedImageNumber!) of \(totalImages!)"
    navigationItem.largeTitleDisplayMode = .never
    
    if let imageToLoad = selectedImage {
      imageView.image = UIImage(named: imageToLoad)
    }
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.hidesBarsOnTap = true
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    navigationController?.hidesBarsOnTap = false
  }
}
