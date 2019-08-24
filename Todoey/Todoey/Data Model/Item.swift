//
//  Item.swift
//  Todoey
//
//  Created by Ismail Elmaliki on 8/24/19.
//  Copyright © 2019 Ismail Elmaliki. All rights reserved.
//

import Foundation

// Codable means class conforms to Encodable and Decodable
class Item: Codable{
	var title: String = ""
	var done: Bool = false
}
