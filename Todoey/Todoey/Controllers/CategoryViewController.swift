//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Ismail Elmaliki on 8/27/19.
//  Copyright © 2019 Ismail Elmaliki. All rights reserved.
//

import UIKit
import RealmSwift
import SwipeCellKit

class CategoryViewController: UITableViewController {

	let realm = try! Realm()
	
	var categoryArray: Results<Category>?
	
	
	override func viewDidLoad() {
        super.viewDidLoad()
		loadCategories()
		
		tableView.rowHeight = 80.0
    }

	//MARK: - Add New Categories
	@IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
		var textField = UITextField()
		// Alert box content
		let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
		alert.addTextField { (alertTextField) in
			alertTextField.placeholder = "Add New Category"
			textField = alertTextField
		}
		
		// Action 1
		let action = UIAlertAction(title: "Add", style: .default) { (action) in
			
			// What will happen once user clicks Add Item button on Alert
			let newCategory = Category()
			newCategory.name = textField.text!
			
			self.saveCategories(category: newCategory)
		}
		
		alert.addAction(action)
		present(alert, animated: true, completion: nil)
	}
	
	//MARK: - TableView Datasource Methods
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		
		performSegue(withIdentifier: "goToItems", sender: self)
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		let destinationVC = segue.destination as! TodoListViewController
		
		if let indexPath = tableView.indexPathForSelectedRow {
			destinationVC.selectedCategory = categoryArray?[indexPath.row]
		}
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return categoryArray?.count ?? 1
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		// Allows me to create a cell into TableView identifier
		let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as! SwipeTableViewCell
		
		// Actually populating the cell with the array contents for each row
		cell.textLabel?.text = categoryArray?[indexPath.row].name ?? "No Categories added yet"
		
		cell.delegate = self
		
		return cell
	}
	
	//MARK: - Data Manipulation Methods
	func saveCategories(category: Category) {
		do {
			try realm.write {
				realm.add(category)
			}
		} catch {
			print("Error encoding item in array, \(error)")
		}
		// Reloads tableView to ensure recently appended data appears in TableView
		self.tableView.reloadData()
	}
	
	func loadCategories() {
		categoryArray = realm.objects(Category.self)
		
		tableView.reloadData()
	}
	
	
	//MARK: - TableView Delegate Methods - save this for now
}


// MARK: Swipe cell delegate methods
extension CategoryViewController: SwipeTableViewCellDelegate {
	func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
		guard orientation == .right else { return nil }
		
		let deleteAction = SwipeAction(style: .destructive, title: "Delete") {action, indexPath in
			// Handle action by updating model with deletion
		}
		
		// customize the action appearence
		deleteAction.image = UIImage(named: "delete-icon")
		
		return [deleteAction]
	}
}
