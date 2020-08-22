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
  
  var checklist: Checklist?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    title = checklist?.name ?? "Name of the checklist"
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
          controller.itemToEdit = checklist?.items[indexPath.row]
        }
      }
    }
  }
  
  //MARK:- Table View Delegate
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    if let cell = tableView.cellForRow(at: indexPath),
      let item = checklist?.items[indexPath.row] {
      item.toggleChecked()
      configureCheckmark(for: cell, with: item)
    }
    
    tableView.deselectRow(at: indexPath, animated: true)
    tableView.reloadData()
  }
  
  override func tableView(_ tableView: UITableView,
                          commit editingStyle: UITableViewCell.EditingStyle,
                          forRowAt indexPath: IndexPath) {
    checklist?.items.remove(at: indexPath.row)
    tableView.reloadData()
  }
  
  // MARK:- Table View Data Source
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int
  ) -> Int {
    return checklist?.items.count ?? 0
  }
  
  override func tableView(
    _ tableView: UITableView, cellForRowAt indexPath: IndexPath
  ) -> UITableViewCell {
    let cell = tableView
      .dequeueReusableCell(withIdentifier: "ChecklistItem", for: indexPath)
    if let item = checklist?.items[indexPath.row] {
      configureText(for: cell, with: item)
      configureCheckmark(for: cell, with: item)
    }
    return cell
  }
  
  //MARK:- AddItemViewController Delegate
  
  func itemDetailViewControllerDidCancel(_ controller: ItemDetailViewController) {
    navigationController?.popViewController(animated: true)
  }
  
  func itemDetailViewController(_ controller: ItemDetailViewController,
                             didFinishAdding item: ChecklistItem) {
    checklist?.items.append(item)
    tableView.reloadData()
    
    navigationController?.popViewController(animated: true)
  }
  
  func itemDetailViewController(_ controller: ItemDetailViewController,
                             didFinishEditing item: ChecklistItem) {
    if let index = checklist?.items.firstIndex(where: { $0 == item }) {
      let indexPath = IndexPath(row: index, section: 0)
      if let cell = tableView.cellForRow(at: indexPath) {
        configureText(for: cell, with: item)
      }
    }
    
    navigationController?.popViewController(animated: true)
  }
}

