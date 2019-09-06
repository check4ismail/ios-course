import Foundation

// Example of an observed property
var pizzaInInches: Int = 10 {
	// Right before pizzaInInches is changed, willSet is triggerred
	willSet {
		print(pizzaInInches) // Old value
		print(newValue) // Only available in newValue
	}
	// When pizzaInInches is set, block of code under is triggered
	didSet {
		print(oldValue) // Only available in didSet
		print(pizzaInInches) // New value
	}
}
var numberOfPeople: Int = 12
let slicesPerPerson: Int = 4

var numberOfSlices: Int {
	// getter
	get {
		return pizzaInInches - 4
	}
	
	// setter
	set {
		
	}
}

var numberOfPizza: Int {
	get {
		let numberOfPeopleFedPerPizza = numberOfSlices / slicesPerPerson
		return numberOfPeople / numberOfPeopleFedPerPizza
	}
	set {
		let totalSlices = numberOfSlices * newValue // Predefined in the setter
		numberOfPeople = totalSlices / slicesPerPerson
	}
}

numberOfPizza = 4
print(numberOfPizza)
