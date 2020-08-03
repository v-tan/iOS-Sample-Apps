//
//  ViewController.swift
//  checklists
//
//  Created by Varun Tandon on 29/07/20.
//  Copyright © 2020 Varun Tandon. All rights reserved.
//

import UIKit

class ChecklistViewController: UITableViewController,
ItemDetailViewControllerDelegate {
  
  var items = [ChecklistItem]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    loadChecklistItems()
  }
  
  func configureText(for cell: UITableViewCell,
                     with item: ChecklistItem) {
    if let label = cell.viewWithTag(1000) as? UILabel {
      label.text = item.text
    }
  }
  
  func configureCheckmark(for cell: UITableViewCell, with item: ChecklistItem) {
    if let label = cell.viewWithTag(1001) as? UILabel {
      if item.checked {
        label.text = "√"
      } else {
        label.text = ""
      }
    }
  }
  
  func documentsDirectory() -> URL {
    let paths = FileManager.default.urls(for: .documentDirectory,
                                          in: .userDomainMask)
    return paths[0]
  }

  func dataFilePath() -> URL {
    return documentsDirectory().appendingPathComponent("Checklists.plist")
  }
  
  func saveChecklistItems() {
    let encoder = PropertyListEncoder()
    do {
      let data = try encoder.encode(items)
      try data.write(to: dataFilePath(), options: Data.WritingOptions.atomic)
    } catch {
      print("Error encoding item array: \(error.localizedDescription)")
    }
  }
  
  func loadChecklistItems() {
    let path = dataFilePath()
    if let data = try? Data(contentsOf: path) {
      let decoder = PropertyListDecoder()
      do {
        items = try decoder.decode([ChecklistItem].self, from: data)
      } catch {
        print("Error decoding item array: \(error.localizedDescription)")
      }
    }
  }
  
  // MARK:- Navigation
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "AddItem" {
      if let controller = segue.destination as? ItemDetailViewController {
        controller.delegate = self
      }
    } else if segue.identifier == "EditItem" {
      if let controller = segue.destination as? ItemDetailViewController {
        controller.delegate = self
        
        if let sender = sender as? UITableViewCell,
          let indexPath = tableView.indexPath(for: sender) {
          controller.itemToEdit = items[indexPath.row]
        }
      }
    }
  }
  
  //MARK:- Table View Delegate
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    if let cell = tableView.cellForRow(at: indexPath) {
      let item = items[indexPath.row]
      item.toggleChecked()
      configureCheckmark(for: cell, with: item)
      saveChecklistItems()
    }
    
    tableView.deselectRow(at: indexPath, animated: true)
    tableView.reloadData()
  }
  
  override func tableView(_ tableView: UITableView,
                          commit editingStyle: UITableViewCell.EditingStyle,
                          forRowAt indexPath: IndexPath) {
    items.remove(at: indexPath.row)
    tableView.reloadData()
    saveChecklistItems()
  }
  
  // MARK:- Table View Data Source
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int
  ) -> Int {
    return items.count
  }
  
  override func tableView(
    _ tableView: UITableView, cellForRowAt indexPath: IndexPath
  ) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "ChecklistItem", for: indexPath)
    let item = items[indexPath.row]
    
    configureText(for: cell, with: item)
    configureCheckmark(for: cell, with: item)
    
    return cell
  }
  
  //MARK:- AddItemViewController Delegate
  
  func itemDetailViewControllerDidCancel(_ controller: ItemDetailViewController) {
    navigationController?.popViewController(animated: true)
  }
  
  func itemDetailViewController(_ controller: ItemDetailViewController,
                             didFinishAdding item: ChecklistItem) {
    items.append(item)
    tableView.reloadData()
    
    navigationController?.popViewController(animated: true)
    saveChecklistItems()
  }
  
  func itemDetailViewController(_ controller: ItemDetailViewController,
                             didFinishEditing item: ChecklistItem) {
    if let index = items.firstIndex(where: { $0 == item }) {
      let indexPath = IndexPath(row: index, section: 0)
      if let cell = tableView.cellForRow(at: indexPath) {
        configureText(for: cell, with: item)
      }
    }
    
    navigationController?.popViewController(animated: true)
    saveChecklistItems()
  }
}
