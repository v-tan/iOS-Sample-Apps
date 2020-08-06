//
//  AllListsViewController.swift
//  checklists
//
//  Created by Varun Tandon on 06/08/20.
//  Copyright © 2020 Varun Tandon. All rights reserved.
//

import UIKit

class AllListsViewController: UITableViewController {
  
  let cellIdentifier = "ChecklistCell"
  var lists = [Checklist]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
    
    var list = Checklist(name: "Birthdays")
    lists.append(list)

    list = Checklist(name: "Groceries")
    lists.append(list)

    list = Checklist(name: "Cool Apps")
    lists.append(list)

    list = Checklist(name: "To Do")
    lists.append(list)
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "ShowChecklist" {
      if let controller = segue.destination as? ChecklistViewController {
        controller.checklist = sender as? Checklist
      }
    }
  }
  
  // MARK: - Table view data source
  
  override func tableView(
    _ tableView: UITableView, numberOfRowsInSection section: Int
  ) -> Int {
    return lists.count
  }
  
  override func tableView(
    _ tableView: UITableView, cellForRowAt indexPath: IndexPath
  ) -> UITableViewCell {
    let cell = tableView
      .dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
    cell.textLabel?.text = "\(lists[indexPath.row].name)"
    cell.accessoryType = .detailDisclosureButton
    return cell
  }
  
  override func tableView(
    _ tableView: UITableView, didSelectRowAt indexPath: IndexPath
  ) {
    let checklist = lists[indexPath.row]
      performSegue(withIdentifier: "ShowChecklist", sender: checklist)
  }
}
