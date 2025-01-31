//
//  ViewController.swift
//  Todoey
//
//  Created by Ismail Elmaliki on 8/22/19.
//  Copyright © 2019 Ismail Elmaliki. All rights reserved.
//

import UIKit
import RealmSwift
import ChameleonFramework

// Subclassing UITableViewController includes all the components we need
class TodoListViewController: SwipeTableViewController {

	var todoItems : Results<Item>?
	let realm = try! Realm()
	@IBOutlet weak var searchBar: UISearchBar!
	var selectedCategory: Category? {
		// As soon as variable is set, perform an action
		didSet {
			loadItems()
		}
	}
	

//	let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
	
	override func viewDidLoad() {
		super.viewDidLoad()
		tableView.separatorStyle = .none
		tableView.rowHeight = 80.0
//		print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
	}
	
	override func viewWillAppear(_ animated: Bool) {
		
		title = selectedCategory?.name
		guard let colorHex = selectedCategory?.color else { fatalError() }
		
		updateNavBar(withHexCode: colorHex)
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		updateNavBar(withHexCode: "1D9BF6")
	}
	
	//MARK: - Nav Bar Setup Methods
	func updateNavBar(withHexCode colorHexCode: String) {
		guard let navBar = navigationController?.navigationBar else {
			fatalError("Navigation bar does not exist.")
		}
		guard let navBarColor = UIColor(hexString: colorHexCode) else { fatalError() }
		navBar.barTintColor = navBarColor
		navBar.tintColor = ContrastColorOf(navBarColor, returnFlat: true)
		navBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor : ContrastColorOf(navBarColor, returnFlat: true)]
		searchBar.barTintColor = navBarColor
		
	}
	
	//MARK: - Tableview Datasource Methods
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return todoItems?.count ?? 1
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		// Allows me to create a cell into TableView identifier
		let cell = super.tableView(tableView, cellForRowAt: indexPath)

		// Actually populating the cell with the array contents for each row
		if let item = todoItems?[indexPath.row] {
			// Using ternary operator
			cell.textLabel?.text = item.title
			
			if let color = UIColor(hexString: selectedCategory!.color)?.darken(byPercentage: CGFloat(indexPath.row) / CGFloat(todoItems!.count)) {
				cell.backgroundColor = color
				cell.textLabel?.textColor = ContrastColorOf(color, returnFlat: true)
			}
			cell.accessoryType = item.done ? .checkmark : .none
		} else {
			cell.textLabel?.text = "No Items Added"
		}
		
		return cell
	}
	
	//MARK: - TableView Delegate Methods
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		// indexPath.row -> the current row being selected
		
		if let item = todoItems?[indexPath.row] {
			do {
				try realm.write {
					// deleting in realm
//					realm.delete(item)
				item.done = !item.done
				}
			} catch{
				print("Error saving done status, \(error)")
			}
		}
		
		tableView.reloadData()
		
		// Quickly taps cell - prevents gray color from sticking to cell
//		tableView.deselectRow(at: indexPath, animated: true)
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
			if let currentCategory = self.selectedCategory {
				do {
					try self.realm.write {
						let newItem = Item()
						newItem.title = textField.text!
						newItem.setDateCreated()
						currentCategory.items.append(newItem)
					}
				} catch {
					print("Error saving new items, \(error)")
				}
			}
			self.tableView.reloadData()
		}
		
		alert.addAction(action)
		present(alert, animated: true, completion: nil)
	}
	
	override func updateModel(at indexPath: IndexPath) {
		if let itemForDeletion = self.todoItems?[indexPath.row] {
			do {
				try self.realm.write {
					self.realm.delete(itemForDeletion)
				}
			} catch {
				print("Error removing category from realm: \(error)")
			}
			tableView.reloadData()
		}
	}
	
	//MARK: load data method from Core Data
	func loadItems() {

		todoItems = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
		tableView.reloadData()
		dump(selectedCategory?.items)
	}
}

// MARK: Search bar methods
extension TodoListViewController: UISearchBarDelegate {
	
	// MARK: Querying core data
	func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
		
		todoItems = todoItems?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "dateCreated", ascending: true)
		tableView.reloadData()
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
