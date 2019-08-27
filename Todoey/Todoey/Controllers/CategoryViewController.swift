//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Ismail Elmaliki on 8/27/19.
//  Copyright © 2019 Ismail Elmaliki. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {

	var categoryArray = [Category]()
	let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
	
	override func viewDidLoad() {
        super.viewDidLoad()
		loadItems()
    }

	//MARK: - Add New Categories
	@IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
		var textField = UITextField()
		// Alert box content
		let alert = UIAlertController(title: "Add New Todoey Category", message: "", preferredStyle: .alert)
		alert.addTextField { (alertTextField) in
			alertTextField.placeholder = "Create new category"
			textField = alertTextField
		}
		
		// Action 1
		let action = UIAlertAction(title: "Add Category", style: .default) { (action) in
			
			// What will happen once user clicks Add Item button on Alert
			let newCategory = Category(context: self.context)
			newCategory.name = textField.text!
			self.categoryArray.append(newCategory)
			
			self.saveCategories()
		}
		
		alert.addAction(action)
		present(alert, animated: true, completion: nil)
	}
	
	//MARK: - TableView Datasource Methods
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		
		// Quickly taps cell - prevents gray color from sticking to cell
		tableView.deselectRow(at: indexPath, animated: true)
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return categoryArray.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		// Allows me to create a cell into TableView identifier
		let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
		
		// Actually populating the cell with the array contents for each row
		cell.textLabel?.text = categoryArray[indexPath.row].name
		
		return cell
	}
	
	//MARK: - Data Manipulation Methods
	func saveCategories() {
		do {
			try context.save()
		} catch {
			print("Error encoding item in array, \(error)")
		}
		// Reloads tableView to ensure recently appended data appears in TableView
		self.tableView.reloadData()
	}
	
	func loadItems(with request: NSFetchRequest<Category> = Category.fetchRequest()) {
		// ^ uses default value
		do {
			categoryArray = try context.fetch(request)
		} catch {
			print("Error fetching data from context \(error)")
		}
		
		tableView.reloadData()
	}
	
	
	//MARK: - TableView Delegate Methods - save this for now
}
