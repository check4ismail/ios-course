//
//  ViewController.swift
//  Calculator
//
//  Created by Ismail Elmaliki
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
	private var calculator = CalculatorLogic()
	
	// MARK: Action when a non-number button is pressed
    @IBAction func calcButtonPressed(_ sender: UIButton) {
	
		isFinishedTyping = true
		
		calculator.setNumber(displayValue)
		if let calcMethod = sender.currentTitle {
			if let result = calculator.calculate(symbol: calcMethod) {
				displayValue = result
			}
		}
    }

	
	// MARK: Action when number is entered into keypad
    @IBAction func numButtonPressed(_ sender: UIButton) {
	
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

