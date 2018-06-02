//
//  ViewController.swift
//  ToDoApp
//
//  Created by Ivica Markovic on 1/6/18.
//  Copyright © 2018 Ivica Markovic. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    let todoArray = ["first", "Second", "Third"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
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
    //This is for Behaviour when the cell did get selected
        //make sure the cell is deselected after being pressed
    //set accessory to checkmark once pressed
        //turn off if checkmark is already on 
    
    
}

