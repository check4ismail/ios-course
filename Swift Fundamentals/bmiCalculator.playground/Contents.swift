import UIKit

func calculateBmi(mass: Double, height: Double){
	// Rounded bmi to 3 decimal places
	let bmi = (mass / (height * height) * 1000).rounded() / 1000
	
	if bmi > 25 {
		print("Your bmi is \(bmi) - which is overweight")
	}
	else if bmi >= 18.5 && bmi <= 25 {
		print("Your bmi is \(bmi) - which is normal")
	}
	else {
		print("Your bmi is \(bmi) - which is underweight")
	}
}

var mass : Double = 68, height : Double = 1.8288
calculateBmi(mass: mass, height: height)
