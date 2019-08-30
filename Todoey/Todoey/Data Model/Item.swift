//
//  Item.swift
//  Todoey
//
//  Created by Ismail Elmaliki on 8/29/19.
//  Copyright © 2019 Ismail Elmaliki. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
	@objc dynamic var title: String = ""
	@objc dynamic var done: Bool = false
	@objc dynamic var dateCreated: String = ""
	var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
	
	func setDateCreated() {
		let date = Date()
		let format = DateFormatter()
		format.dateFormat = "yyyy-MM-dd HH:mm:ss"
		dateCreated = format.string(from: date)
	}
}
