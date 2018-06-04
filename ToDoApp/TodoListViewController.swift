//
//  ViewController.swift
//  ToDoApp
//
//  Created by Ivica Markovic on 1/6/18.
//  Copyright © 2018 Ivica Markovic. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    var todoArray: [String] = ["First", "Second"]
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
        if let item = (self.defaults.array(forKey: "ToDoListArray") as? [String]) {
            todoArray = item
            
        }

    }
    
    //MARK: TableVIew Datasource methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        cell.textLabel?.text = todoArray[indexPath.row]
        
        return cell
        
    }
    
    //MARK: Tableview Delegate Method
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
    }
    
    //MARK: Add New Items #237
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        print("buttonPressed")
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Todo", message: "Add a Todo", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            if textField.text == "" {
                
                alert.title = "NO ITEM ADDED!"
                self.present(alert, animated: true, completion: nil)
                
            } else {
                
                self.todoArray.append(textField.text!)
                
                //save updated item array to user defaults (defautls.set)
                self.defaults.set(self.todoArray, forKey: "ToDoListArray")
                
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

