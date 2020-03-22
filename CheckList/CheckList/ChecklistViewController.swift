//
//  ViewController.swift
//  CheckList
//
//  Created by Simone Tissi on 20/03/2020.
//  Copyright © 2020 Simone Tissi. All rights reserved.
//

import UIKit

class ChecklistViewController: UITableViewController {
  
  var todoList: TodoList
  
  private func priorityForSectionIndex(_ index: Int) -> TodoList.Priority? {
    return TodoList.Priority(rawValue: index)
  }
  
  @IBAction func addItem(_ sender: Any) {
    let newRowIndex = todoList.todoList(for: .medium).count
    _ = todoList.newTodo()
    
    let indexPath = IndexPath(row: newRowIndex, section: 0)
    let indexPaths = [indexPath]
    tableView.insertRows(at: indexPaths, with: .automatic)
  }
  
  @IBAction func deleteItems(_ sender: Any) {
    if let selectedRows = tableView.indexPathsForSelectedRows{
      for indexPath in selectedRows {
        if let priority = priorityForSectionIndex(indexPath.section){
          let todos = todoList.todoList(for: priority)
          let rowToDelete = indexPath.row > todos.count - 1 ? todos.count - 1 : indexPath.row
          let item = todos[rowToDelete]
          todoList.remove(item, from: priority, at: rowToDelete)
        }
      }
      tableView.beginUpdates()
      tableView.deleteRows(at: selectedRows, with: .automatic)
      tableView.endUpdates()
    }
  }
  
  required init?(coder: NSCoder) {
    todoList = TodoList()
    super.init(coder: coder)
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    navigationController?.navigationBar.prefersLargeTitles = true
    navigationItem.leftBarButtonItem = editButtonItem
    tableView.allowsMultipleSelectionDuringEditing = true
  }
  
  func configureCheckmark(for cell: UITableViewCell, with item: ChecklistItem){
    guard let checkmark = cell as? ChecklistTableViewCell else { return }
    if item.isChecked{
      checkmark.checkmarkLabel.text = "√"
    }else {
      checkmark.checkmarkLabel.text = ""
    }
  }
  
  func configureText(for cell: UITableViewCell, with item: ChecklistItem){
    if let checkmarkCell = cell as? ChecklistTableViewCell{
      checkmarkCell.todoTextLabel.text = item.text
    }
  }
  override func setEditing(_ editing: Bool, animated: Bool) {
    super.setEditing(editing, animated: true)
    tableView.setEditing(tableView.isEditing, animated: true)
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if let priority = priorityForSectionIndex(section){
      return todoList.todoList(for: priority).count
    }
    return 0
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "ChecklistItem", for: indexPath)
    // let item = todoList.todos[indexPath.row]
    if let priority = priorityForSectionIndex(indexPath.section){
      let items = todoList.todoList(for: priority)
      let item = items[indexPath.row]
      configureText(for: cell, with: item)
      configureCheckmark(for: cell, with: item)
    }
    return cell
  }
  
  //What happen when I tap a row
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if tableView.isEditing{
      return
    }
    if let cell = tableView.cellForRow(at: indexPath){
      if let priority = priorityForSectionIndex(indexPath.section){
        let items = todoList.todoList(for: priority)
        let item = items[indexPath.row]
        item.toggleChecked()
        configureCheckmark(for: cell, with: item)
        tableView.deselectRow(at: indexPath, animated: true)
      }
    }
  }
  
  // Swipe for delete
  override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    if let priority = priorityForSectionIndex(indexPath.section){
      let item = todoList.todoList(for: priority)[indexPath.row]
      todoList.remove(item, from: priority, at: indexPath.row)
      let indexPaths = [indexPath]
      tableView.deleteRows(at: indexPaths, with: .automatic)
    }
  }
  
  override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
    if let srcPriority = priorityForSectionIndex(sourceIndexPath.section),
       let destPriority = priorityForSectionIndex(destinationIndexPath.section){
      let item = todoList.todoList(for: srcPriority)[sourceIndexPath.row]
      todoList.move(item: item, from: srcPriority, at: sourceIndexPath.row, to: destPriority, at: destinationIndexPath.row)
    }
    tableView.reloadData()
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "AddItemSegue" {
      if let itemDetailViewController = segue.destination as? ItemDetailViewController{
        itemDetailViewController.delegate = self
        itemDetailViewController.todoList = todoList
      }
    }else if segue.identifier == "EditItemSegue"{
      if let itemDetailViewController = segue.destination as? ItemDetailViewController{
        if let cell = sender as? UITableViewCell,
           let indexPath = tableView.indexPath(for: cell),
           let priority = priorityForSectionIndex(indexPath.section){
          let item = todoList.todoList(for: priority)[indexPath.row]
          itemDetailViewController.itemToEdit = item
          itemDetailViewController.delegate = self
        }
      }
    }
  }
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return TodoList.Priority.allCases.count
  }
  
  override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    var title: String? = nil
    if let priority = priorityForSectionIndex(section){
      switch priority {
      case .high:
        title = "High Priority Todos"
      case .medium:
      title = "Medium Priority Todos"
        case .low:
        title = "Low Priority Todos"
        case .no:
        title = "Someday Todo Items"
      }
    }
    return title
  }
}


extension ChecklistViewController: ItemDetailViewControllerDelegate{
  
  func itemDetailViewControllerDidCancel(_ controller: ItemDetailViewController) {
    navigationController?.popViewController(animated: true)
  }
  func itemDetailViewController(_ controller: ItemDetailViewController, didFinishAdding item: ChecklistItem) {
    navigationController?.popViewController(animated: true)
    let rowIndex = todoList.todoList(for: .medium).count - 1
    let indexPath = IndexPath(row: rowIndex, section: TodoList.Priority.medium.rawValue)
    let indexPaths = [indexPath]
    tableView.insertRows(at: indexPaths, with: .automatic)
  }
  func itemDetailViewController(_ controller: ItemDetailViewController, didFinishEditing item: ChecklistItem) {
    for priority in TodoList.Priority.allCases{
      let currentList = todoList.todoList(for: priority)
      if let index = currentList.firstIndex(of: item){
        let indexPath = IndexPath(row: index, section: priority.rawValue)
        if let cell = tableView.cellForRow(at: indexPath){
          configureText(for: cell, with: item)
        }
      }
    }
    navigationController?.popViewController(animated: true)
  }
}

