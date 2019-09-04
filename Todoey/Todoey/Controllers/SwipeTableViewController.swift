//
//  SwipeTableViewController.swift
//  Todoey
//
//  Created by Ismail Elmaliki on 9/4/19.
//  Copyright © 2019 Ismail Elmaliki. All rights reserved.
//

import UIKit
import SwipeCellKit

class SwipeTableViewController: UITableViewController, SwipeTableViewCellDelegate {
	
	//Tableview datasource methods
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		// Allows me to create a cell into TableView identifier
		let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SwipeTableViewCell
		
		cell.delegate = self
		
		return cell
	}
	
	func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
		guard orientation == .right else { return nil }
		
		let deleteAction = SwipeAction(style: .destructive, title: "Delete") {action, indexPath in
			// Handle action by updating model with deletion
			self.updateModel(at: indexPath)

		}
		// customize the action appearence
		deleteAction.image = UIImage(named: "delete-icon")
		return [deleteAction]
	}
	
	
	
	func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeTableOptions {
		var options = SwipeTableOptions()
		options.expansionStyle = .destructive
		return options
	}
	
	func updateModel(at indexPath: IndexPath) {
		// Update data model.
		
	}
}
