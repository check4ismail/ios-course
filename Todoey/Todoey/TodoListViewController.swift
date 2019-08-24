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

	let itemArray = ["Find Mike", "Buy Eggos", "Destroy Demogorgon"]
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
	}
	
	//MARK - Tableview Datasource Methods
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
	
	//MARK - TableView Delegate Methods
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

}

