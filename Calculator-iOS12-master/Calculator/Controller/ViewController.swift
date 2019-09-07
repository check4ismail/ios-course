//
//  ViewController.swift
//  Calculator
//
//  Created by Angela Yu on 10/09/2018.
//  Copyright © 2018 London App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var displayLabel: UILabel!
    private var isFinishedTyping: Bool = true
	private var displayValue: Double {
		get {
			// Gets current value from displaylabel
			guard let number = Double(displayLabel.text!) else { fatalError("Cannot convert display label from text to double") }
			return number
		}
		set {
			// Sets display label
			displayLabel.text = String(newValue)
		}
	}
    
    @IBAction func calcButtonPressed(_ sender: UIButton) {
        
        //What should happen when a non-number button is pressed
		isFinishedTyping = true
		
		if let calcMethod = sender.currentTitle {
			let calculator = CalculatorLogic(number: displayValue)
			guard let result = calculator.calculate(symbol: calcMethod) else { fatalError("Results of calculation is nill") }
			displayValue = result
		}
    }

    
    @IBAction func numButtonPressed(_ sender: UIButton) {
        
        //What should happen when a number is entered into the keypad
		if let numValue = sender.currentTitle {
			
			if isFinishedTyping {
				displayLabel.text = numValue
				isFinishedTyping = false
			} else {
				
				if numValue == "." {
				
					let isInt = floor(displayValue) == displayValue
					
					if !isInt {
						return
					}
				}
				displayLabel.text = displayLabel.text! + numValue
			}
		}
    
    }

}

