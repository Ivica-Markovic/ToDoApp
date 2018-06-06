//
//  ViewController.swift
//  ToDoApp
//
//  Created by Ivica Markovic on 1/6/18.
//  Copyright © 2018 Ivica Markovic. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    var todoData = [TodoData]()
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        print(dataFilePath)
        
        let item1 = TodoData()
        item1.title = "first"
        todoData.append(item1)

        
        let item2 = TodoData()
        item2.title = "second"
        todoData.append(item2)
        
//        if let items = self.defaults.array(forKey: "ToDoListArray") as? [TodoData] {
//            todoData = items
//        }

    }
    
    //MARK: TableVIew Datasource methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = todoData[indexPath.row]
        cell.textLabel?.text = item.title
        
        cell.accessoryType = item.done ? .checkmark : .none
        
        return cell
        
    }
    
    //MARK: Tableview Delegate Method
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        todoData[indexPath.row].done = !todoData[indexPath.row].done

        tableView.deselectRow(at: indexPath, animated: true)
        tableView.reloadData()
        
    }
    
    //MARK: Add New Items #237
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Todo", message: "Add a Todo", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            if textField.text == "" {
                
                alert.title = "NO ITEM ADDED!"
                self.present(alert, animated: true, completion: nil)
                
            } else {
                
                let newItem = TodoData()
                newItem.title = textField.text!
                self.todoData.append(newItem)
                
                //TODO:
                //create a object using propertyListEncoder()
                //in a do catch block "try" to encode the todoArray using .encode()
                
                let encoder = PropertyListEncoder()
                
                do {
                    let data = try encoder.encode(self.todoData)
                    try data.write(to: self.dataFilePath!)
                } catch {
                    print("error \(error)")
                }

                self.tableView.reloadData()
                
            }
            
        }
        let actionCancel = UIAlertAction(title: "Cancel", style: .default) { (action) in
            return
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Item"
            textField = alertTextField
        }
        
        alert.addAction(actionCancel)
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }
    

}
