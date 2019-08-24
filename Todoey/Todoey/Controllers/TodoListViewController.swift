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

	var itemArray = [Item]()
	let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
	override func viewDidLoad() {
		super.viewDidLoad()
		loadItems()
	}
	
	//MARK: - Tableview Datasource Methods
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return itemArray.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		// Allows me to create a cell into TableView identifier
		let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
		
		// Actually populating the cell with the array contents for each row
		cell.textLabel?.text = itemArray[indexPath.row].title
		let item = itemArray[indexPath.row]
		
		// Using ternary operator
		cell.accessoryType = item.done ? .checkmark : .none
		
		return cell
	}
	
	//MARK: - TableView Delegate Methods
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		// indexPath.row -> the current row being selected
		
		// Sets current value to its opposite
		// If true, then make it false. If false, then make it true
		itemArray[indexPath.row].done = !itemArray[indexPath.row].done
	
		saveItems()
		
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
			let newItem = Item()
			newItem.title = textField.text!
			self.itemArray.append(newItem)
			
			self.saveItems()
			
//			Because of our custom class, we can't add our array to UserDefaults
//			self.defaults.set(self.itemArray, forKey: "TodoListArray")
		}
		
		
		alert.addAction(action)
		present(alert, animated: true, completion: nil)
	}
	
	//MARK: Save data method
	func saveItems() {
		let encoder = PropertyListEncoder()
		do {
			let data = try encoder.encode(self.itemArray)
			try data.write(to: self.dataFilePath!)
		} catch {
			print("Error encoding item in array, \(error)")
		}
		// Reloads tableView to ensure recently appended data appears in TableView
		self.tableView.reloadData()
	}
	
	//MARK: load data method
	func loadItems() {
		if let data = try? Data(contentsOf: dataFilePath!) {
			let decoder = PropertyListDecoder()
			do {
				itemArray = try decoder.decode([Item].self, from: data)
			} catch {
				print("Error decoding, \(error)")
			}
		}
	}
}

