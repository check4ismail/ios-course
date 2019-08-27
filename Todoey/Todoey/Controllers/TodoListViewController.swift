//
//  ViewController.swift
//  Todoey
//
//  Created by Ismail Elmaliki on 8/22/19.
//  Copyright © 2019 Ismail Elmaliki. All rights reserved.
//

import UIKit
import CoreData

// Subclassing UITableViewController includes all the components we need
class TodoListViewController: UITableViewController {

	var itemArray = [Item]()
	let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
//	let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
	
	override func viewDidLoad() {
		super.viewDidLoad()
		print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
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
		
//		context.delete(itemArray[indexPath.row])
//		itemArray.remove(at: indexPath.row)
		
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
		let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
		alert.addTextField { (alertTextField) in
			alertTextField.placeholder = "Create new item"
			textField = alertTextField
		}
		
		// Action 1
		let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
			
			// What will happen once user clicks Add Item button on Alert
			let newItem = Item(context: self.context)
			newItem.title = textField.text!
			newItem.done = false
			self.itemArray.append(newItem)
			
			self.saveItems()
			
//			Because of our custom class, we can't add our array to UserDefaults
//			self.defaults.set(self.itemArray, forKey: "TodoListArray")
		}
		
		
		alert.addAction(action)
		present(alert, animated: true, completion: nil)
	}
	
	//MARK: Save data method - saves new items using Core Data
	func saveItems() {
		do {
			try context.save()
		} catch {
			print("Error encoding item in array, \(error)")
		}
		// Reloads tableView to ensure recently appended data appears in TableView
		self.tableView.reloadData()
	}
	
	//MARK: load data method from Core Data
	func loadItems(with request: NSFetchRequest<Item> = Item.fetchRequest()) {
		// ^ uses default value
		do {
			itemArray = try context.fetch(request)
		} catch {
			print("Error fetching data from context \(error)")
		}
		
		tableView.reloadData()
	}
}

// MARK: Search bar methods
extension TodoListViewController: UISearchBarDelegate {
	
	// MARK: Querying core data
	func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
		let request: NSFetchRequest<Item> = Item.fetchRequest()
		
		request.predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
		
		request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
		
		loadItems(with: request)
	}
	
	func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
		if searchBar.text?.count == 0 {
			loadItems()

			// Changing UI in an asyncronous to prevent disruption to user
			DispatchQueue.main.async {
				// Return search bar to non-activated state
				searchBar.resignFirstResponder()
			}
		}
	}
}
