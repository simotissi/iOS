//
//  TodoList.swift
//  CheckList
//
//  Created by Simone Tissi on 21/03/2020.
//  Copyright © 2020 Simone Tissi. All rights reserved.
//

import Foundation

class TodoList{
  
  enum Priority: Int, CaseIterable {
    case high, medium, low, no
  }
  
  private var highPriorityTodos:[ChecklistItem] = []
  private var mediumPriorityTodos:[ChecklistItem] = []
  private var lowPriorityTodos:[ChecklistItem] = []
  private var noPriorityTodos:[ChecklistItem] = []

  init(){
    let row0Item = ChecklistItem()
    let row1Item = ChecklistItem()
    let row2Item = ChecklistItem()
    let row3Item = ChecklistItem()
    let row4Item = ChecklistItem()
    let row5Item = ChecklistItem()
    let row6Item = ChecklistItem()
    let row7Item = ChecklistItem()
    
    row0Item.text = "Take a jog"
    row1Item.text = "Watch a movie"
    row2Item.text = "Code an app"
    row3Item.text = "Walk the dog"
    row4Item.text = "Study design patterns"
    row5Item.text = "Scroll FB"
    row6Item.text = "Cook the dinner"
    row7Item.text = "Go to bathroom"
    
    
    addTodo(row0Item, for: .medium)
    addTodo(row1Item, for: .low)
    addTodo(row2Item, for: .medium)
    addTodo(row3Item, for: .no)
    addTodo(row4Item, for: .high)
    addTodo(row5Item, for: .low)
    addTodo(row6Item, for: .no)
    addTodo(row7Item, for: .high)
  }
  
  func addTodo(_ item: ChecklistItem, for priority: Priority, at index: Int = -1){
    switch priority {
      case .high:
        if index < 0 {
          highPriorityTodos.append(item)
        }else{
          highPriorityTodos.insert(item, at: index)
        }
      case .medium:
       if index < 0 {
         mediumPriorityTodos.append(item)
       }else{
         mediumPriorityTodos.insert(item, at: index)
       }
      case .low:
       if index < 0 {
         lowPriorityTodos.append(item)
       }else{
         lowPriorityTodos.insert(item, at: index)
       }
      case .no:
       if index < 0 {
         noPriorityTodos.append(item)
       }else{
         noPriorityTodos.insert(item, at: index)
       }
    }
  }
  
  func todoList(for priority: Priority)-> [ChecklistItem]{
    switch priority {
      case .high:
        return highPriorityTodos
      case .medium:
        return mediumPriorityTodos
      case .low:
        return lowPriorityTodos
      case .no:
        return noPriorityTodos
    }
  }
  
  func newTodo() -> ChecklistItem{
    let item = ChecklistItem()
    item.text = textForNewToDo()
    item.isChecked = true
    mediumPriorityTodos.append(item)
    return item
  }
  
  func move(item: ChecklistItem, from sourcePriority: Priority, at sourceIndex: Int, to destinationPriority: Priority, at destinationIndex: Int){
    remove(item, from: sourcePriority, at: sourceIndex)
    addTodo(item, for: destinationPriority, at: destinationIndex)
  }
  
  func remove(_ item: ChecklistItem, from priority: Priority, at index: Int){
    switch priority {
      case .high:
        highPriorityTodos.remove(at: index)
      case .medium:
        mediumPriorityTodos.remove(at: index)
      case .low:
        lowPriorityTodos.remove(at: index)
      case .no:
        noPriorityTodos.remove(at: index)
    }
  }
  
  private func textForNewToDo() -> String{
    let titles = ["Sleep","Clean bathroom","Clean bedroom","Scrool FB","Make dinner"]
    let randomNum = Int.random(in: 1...titles.count-1)
    return titles[randomNum]
  }
}
