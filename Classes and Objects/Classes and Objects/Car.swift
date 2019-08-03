//
//  Car.swift
//  Classes and Objects
//
//  Created by Ismail Elmaliki on 7/31/19.
//  Copyright © 2019 Ismail Elmaliki. All rights reserved.
//

import Foundation

enum CarType {
	case Sedan
	case Coupe
	case Hatchback
	case SUV
}

class Car {
	// Properties of car
	var color : String = "Black"
	var numberOfSeats : Int = 5
	var typeOfCar : CarType = .Coupe
	
	init() {
		
	}
	
	convenience init(color : String, numberOfSeats : Int, typeOfCar : CarType) {
		self.init()
		self.color = color
		self.numberOfSeats = numberOfSeats
		self.typeOfCar = typeOfCar
	}
	
	func drive() {
		print("Car is driving")
	}
}
