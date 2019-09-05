//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Ismail Elmaliki on 8/27/19.
//  Copyright © 2019 Ismail Elmaliki. All rights reserved.
//

import UIKit
import RealmSwift
import ChameleonFramework

class CategoryViewController: SwipeTableViewController {

	let realm = try! Realm()
	
	var categoryArray: Results<Category>?
	
	
	override func viewDidLoad() {
        super.viewDidLoad()
		loadCategories()
		
		tableView.separatorStyle = .none
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
			newCategory.color = UIColor.randomFlat.hexValue()
//			print("Category color: \(newCategory.color)")
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
		let cell = super.tableView(tableView, cellForRowAt: indexPath)
		
		guard let category = categoryArray?[indexPath.row] else { fatalError() }
		cell.textLabel?.text = category.name
		
		guard let categoryColor = UIColor(hexString: category.color) else { fatalError() }
		cell.backgroundColor = categoryColor
		cell.textLabel?.textColor = ContrastColorOf(categoryColor, returnFlat: true)
//		print("Cell cat color: \(categoryArray?[indexPath.row].color)")
		
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
	
	//MARK: - Delete data from swipe
	override func updateModel(at indexPath: IndexPath) {
		if let categoryForDeletion = self.categoryArray?[indexPath.row] {
			do {
				try self.realm.write {
					self.realm.delete(categoryForDeletion)
				}
			} catch {
				print("Error removing category from realm: \(error)")
			}
			tableView.reloadData()
		}
	}
}
