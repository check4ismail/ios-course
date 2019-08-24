//
//  ViewController.swift
//  Todoey
//
//  Created by Ismail Elmaliki on 8/22/19.
//  Copyright © 2019 Ismail Elmaliki. All rights reserved.
//

import UIKit

// Subclassing UITableViewController includes all the components we need
class TodoListViewController: UITableViewController {

	var itemArray = ["Find Mike", "Buy Eggos", "Destroy Demogorgon"]
	
	// 1. Using Defaults for data persistence
	let defaults = UserDefaults.standard
	override func viewDidLoad() {
		super.viewDidLoad()
		
		if let items = defaults.array(forKey: "TodoListArray") as? [String] {
			itemArray = items
		}
		
	}
	
	//MARK: - Tableview Datasource Methods
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return itemArray.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		// Allows me to create a cell into TableView identifier
		let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
		
		// Actually populating the cell with the array contents for each row
		cell.textLabel?.text = itemArray[indexPath.row]
		
		return cell
	}
	
	//MARK: - TableView Delegate Methods
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		// indexPath.row -> the current row being selected
		
		let cell = tableView.cellForRow(at: indexPath)
		
		if cell?.accessoryType == .checkmark {
			cell?.accessoryType = .none
		} else {
			cell?.accessoryType = .checkmark
		}
		
		// Quickly taps cell - prevents gray color from sticking to cell
		tableView.deselectRow(at: indexPath, animated: true)
	}

	//MARK: - Add new items
	@IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
		/*
			Was able to change the Bar Button to a "+" symbol by going to the
			Attribute inspector then changing System item to "Add"
		*/
		
		var textField = UITextField()
		// Alert box content
		let alert = UIAlertController(title: "Add New Todoey Item", message: "ff", preferredStyle: .alert)
		alert.addTextField { (alertTextField) in
			alertTextField.placeholder = "Create new item"
			textField = alertTextField
		}
		
		// Action 1
		let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
			// What will happen once user clicks Add Item button on Alert
			self.itemArray.append(textField.text!)
			self.defaults.set(self.itemArray, forKey: "TodoListArray")
			
			// Reloads tableView to ensure recently appended data appears in TableView
			self.tableView.reloadData()
		}
		
		
		alert.addAction(action)
		present(alert, animated: true, completion: nil)
	}
}

