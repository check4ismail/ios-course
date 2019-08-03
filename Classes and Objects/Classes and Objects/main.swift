//
//  main.swift
//  Classes and Objects
//
//  Created by Ismail Elmaliki on 7/31/19.
//  Copyright © 2019 Ismail Elmaliki. All rights reserved.
//

import Foundation

// Class object
let myCar = Car(color: "blue", numberOfSeats: 7, typeOfCar: .SUV)

print(myCar.numberOfSeats)
print(myCar.color)
print(myCar.typeOfCar)
myCar.drive()

let mySelfDrivingCar = SelfDrivingCar(color: "Midnight Blue", numberOfSeats: 8, typeOfCar: .SUV)
print(mySelfDrivingCar.numberOfSeats)
print(mySelfDrivingCar.color)
print(mySelfDrivingCar.typeOfCar)
mySelfDrivingCar.drive()

let mySelfDrivingCarTwo = SelfDrivingCar(color: "Midnight Blue", numberOfSeats: 8, typeOfCar: .SUV, destination: "1 Infinite Loop")
print(mySelfDrivingCarTwo.numberOfSeats)
print(mySelfDrivingCarTwo.color)
print(mySelfDrivingCarTwo.typeOfCar)

// Optional binding - a safety check to ensure nil pointer exception
// does NOT occur
if let userSetDestination = mySelfDrivingCarTwo.destination {
	print(userSetDestination)
}
