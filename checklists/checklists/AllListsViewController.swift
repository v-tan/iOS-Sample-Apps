//
//  AllListsViewController.swift
//  checklists
//
//  Created by Varun Tandon on 06/08/20.
//  Copyright © 2020 Varun Tandon. All rights reserved.
//

import UIKit

class AllListsViewController: UITableViewController, ListDetailViewControllerDelegate {
  
  let cellIdentifier = "ChecklistCell"
  var lists = [Checklist]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
    
    // Load data
    loadChecklists()
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "ShowChecklist" {
      if let controller = segue.destination as? ChecklistViewController {
        controller.checklist = sender as? Checklist
      }
    } else if segue.identifier == "AddChecklist" {
      if let controller = segue.destination as? ListDetailViewController {
        controller.delegate = self
      }
    }
  }
  
  // MARK:- Data Saving
  func documentsDirectory() -> URL {
    let paths = FileManager.default.urls(for: .documentDirectory,
                                          in: .userDomainMask)
    return paths[0]
  }

  func dataFilePath() -> URL {
    return documentsDirectory().appendingPathComponent(
                                    "Checklists.plist")
  }

  // this method is now called saveChecklists()
  func saveChecklists() {
    let encoder = PropertyListEncoder()
    do {
      // You encode lists instead of "items"
      let data = try encoder.encode(lists)
      try data.write(to: dataFilePath(),
                options: Data.WritingOptions.atomic)
    } catch {
      print("Error encoding list array: \(error.localizedDescription)")
    }
  }

  // this method is now called loadChecklists()
  func loadChecklists() {
    let path = dataFilePath()
    if let data = try? Data(contentsOf: path) {
      let decoder = PropertyListDecoder()
      do {
        // You decode to an object of [Checklist] type to lists
        lists = try decoder.decode([Checklist].self, from: data)
      } catch {
        print("Error decoding list array: \(error.localizedDescription)")
      }
    }
  }
  
  override func tableView(
    _ tableView: UITableView,
    commit editingStyle: UITableViewCell.EditingStyle,
    forRowAt indexPath: IndexPath) {
    lists.remove(at: indexPath.row)
    
    let indexPaths = [indexPath]
    tableView.deleteRows(at: indexPaths, with: .automatic)
  }
  
  // MARK:- List Detail View Controller Delegates
  func listDetailViewControllerDidCancel(
    _ controller: ListDetailViewController) {
    navigationController?.popViewController(animated: true)
  }
  
  func listDetailViewController(
    _ controller: ListDetailViewController,
    didFinishAdding checklist: Checklist) {
    let newRowIndex = lists.count
    lists.append(checklist)
    
    let indexPath = IndexPath(row: newRowIndex, section: 0)
    let indexPaths = [indexPath]
    tableView.insertRows(at: indexPaths, with: .automatic)
    
    navigationController?.popViewController(animated: true)
  }
  
  func listDetailViewController(
    _ controller: ListDetailViewController,
    didFinishEditing checklist: Checklist) {
    if let index = lists.firstIndex(of: checklist) {
      let indexPath = IndexPath(row: index, section: 0)
      if let cell = tableView.cellForRow(at: indexPath) {
        cell.textLabel!.text = checklist.name
      }
    }
    navigationController?.popViewController(animated: true)
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
  
  override func tableView(_ tableView: UITableView,
                          accessoryButtonTappedForRowWith indexPath: IndexPath) {
    guard let controller =
      storyboard?.instantiateViewController(identifier: "ListDetailViewController")
        as? ListDetailViewController else { return }
    
    controller.delegate = self
    
    let checklist = lists[indexPath.row]
    controller.checklistToEdit = checklist
    
    navigationController?.pushViewController(controller, animated: true)
  }
}
