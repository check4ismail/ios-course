//
//  Category.swift
//  Todoey
//
//  Created by Ismail Elmaliki on 8/29/19.
//  Copyright © 2019 Ismail Elmaliki. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
	@objc dynamic var name: String = ""
	let items = List<Item>()
	
	// Another way to initialize an empty array
	// let array = Array<Int>()
}
