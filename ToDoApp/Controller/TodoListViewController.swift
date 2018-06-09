//
//  ViewController.swift
//  ToDoApp
//
//  Created by Ivica Markovic on 1/6/18.
//  Copyright © 2018 Ivica Markovic. All rights reserved.
//

import UIKit
import CoreData

class TodoListViewController: UITableViewController {
    
    var itemArray = [Item]()
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        loadData()
        
        
//        if let items = self.defaults.array(forKey: "ToDoListArray") as? [TodoData] {
//            todoData = items
//        }

    }
    
    //MARK: TableVIew Datasource methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        cell.textLabel?.text = item.title
        
        cell.accessoryType = item.done ? .checkmark : .none
        
        return cell
        
    }
    
    //MARK: Tableview Delegate Method
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        saveItems()

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
                
                
                
                let newItem = Item(context: self.context)
                
                newItem.title = textField.text!
                newItem.done = false
                self.itemArray.append(newItem)
        
                
                self.saveItems()
                
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
    
    //MARK: Model Manipulation Methods
    func saveItems() {
        
        let encoder = PropertyListEncoder()
        
        do {
            try context.save()
        } catch {
            print("error saving context \(error)")
        }
        
        self.tableView.reloadData()
    }
    
    func loadData() {

        do {
            let request : NSFetchRequest<Item> = Item.fetchRequest()
            itemArray = try context.fetch(request)
        } catch {
            print("error \(error)")
        }
    }

}

