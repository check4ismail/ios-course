//
//  SelfDriving.swift
//  Classes and Objects
//
//  Created by Ismail Elmaliki on 7/31/19.
//  Copyright © 2019 Ismail Elmaliki. All rights reserved.
//

import Foundation

// Child class of Car
// ChildClass : ParentClass

enum SelfDrivingBrand {
	case BMW
	case Tesla
	case Lexus
}

class SelfDrivingCar : Car {
	
	var carBrand : SelfDrivingBrand = .Tesla
	var destination : String?
	
	override func drive() {
		// Code
		print("From self driving!")
	}
	
	convenience init(color : String, numberOfSeats : Int, typeOfCar : CarType, destination : String) {
		self.init(color: color, numberOfSeats: numberOfSeats, typeOfCar: typeOfCar)
		self.destination = destination
	}
}
