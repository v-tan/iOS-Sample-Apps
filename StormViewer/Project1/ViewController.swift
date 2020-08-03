//
//  ViewController.swift
//  Project1
//
//  Created by Varun Tandon on 30/03/20.
//  Copyright © 2020 Varun Tandon. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

  var pictures = [String]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    title = "Storm Viewer"
    navigationController?.navigationBar.prefersLargeTitles = true
    
    let fm = FileManager.default
    let path = Bundle.main.resourcePath!
    var items = try! fm.contentsOfDirectory(atPath: path)
    items.sort()
    
    items.forEach { item in
      if item.hasPrefix("nssl") {
        pictures.append(item)
      }
    }
    
    print("pictures: \(pictures)")
  }
  
  override func tableView(_ tableView: UITableView,
                          numberOfRowsInSection section: Int
  ) -> Int {
    return pictures.count
  }
  
  override func tableView(_ tableView: UITableView,
                          cellForRowAt indexPath: IndexPath
  ) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Picture",
                                             for: indexPath)
    cell.textLabel?.text = pictures[indexPath.row]
    return cell
  }
  
  override func tableView(_ tableView: UITableView,
                          didSelectRowAt indexPath: IndexPath) {
    if let detailViewController = storyboard?
      .instantiateViewController(identifier: "Detail") as? DetailViewController {
      detailViewController.selectedImage = pictures[indexPath.row]
      detailViewController.selectedImageNumber = indexPath.row + 1
      detailViewController.totalImages = pictures.count
      navigationController?.pushViewController(detailViewController, animated: true)
    }
  }
}
