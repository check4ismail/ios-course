//
//  ViewController.swift
//  Auto Layout Calculator
//
//  Created by Ismail Elmaliki on 7/30/19.
//  Copyright © 2019 Ismail Elmaliki. All rights reserved.
//

/*
    TO DO:
    1. Take methodical approach via OOP
    2. Clean code
    3. Handle errors correctly while avoiding redundancy
*/

import UIKit

class ViewController: UIViewController {

	
	@IBOutlet weak var numberText: UILabel!
	@IBOutlet var buttonsList : [UIButton]!
	var number = [Double]()
	var operationsStored = [String]()
	let operationType : [Int : String] = [0 : "add", 1 : "sub", 2 : "mul", 3 : "div"]
	
	var numberIndex : Int = 0
	var numberHolder : String = ""
	var operationSelected : Bool = false
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
        resetValues()
	}

	@IBAction func numberPressed(_ sender: UIButton) {
    // Display digits that are pressed
		if operationSelected {
			operationSelected = false
			
			numberHolder = sender.titleLabel?.text ?? ""
			numberText.text = numberHolder
		}
		else {
			numberHolder += sender.titleLabel?.text ?? ""
			numberText.text = numberHolder
		}
	}
	
	
	@IBAction func numOperationSelected(_ sender: UIButton) {
		// Prevents action if operation pressed first
        if numberHolder == "" {
			return
		}
		
		operationSelected = true
		appendDigits()
		
		let operation = sender.tag
		if operation == 0 {
			operationsStored.append(operationType[operation]!)
			print(operationType[operation]! + "")
		}
		else if operation == 1 {
			operationsStored.append(operationType[operation]!)
			print(operationType[operation]! + "")
		}
		else if operation == 2 {
			operationsStored.append(operationType[operation]!)
			print(operationType[operation]! + "")
		}
		else if operation == 3 {
			operationsStored.append(operationType[operation]!)
			print(operationType[operation]! + "")
		}
	}
	
    func appendDigits() {
        // Experimenting with regular expression to ensure correct quantity of digits entered
        print(matches(for: "^(.){0,11}$", in: numberHolder))
        if numberHolder == "" {
            
        }
        number.append(Double(numberHolder)!)
        numberHolder = ""
    }
    
    func matches(for regex: String, in text: String) -> [String] {
        do {
            let regex = try NSRegularExpression(pattern: regex)
            let results = regex.matches(in: text, range: NSRange(text.startIndex..., in: text))
            let finalResult = results.map {
                String(text[Range($0.range, in: text)!])
            }
            return finalResult
        }
        catch let error {
            print("Invalid regex: \(error.localizedDescription)")
            return []
        }
    }
    
    @IBAction func executeOperations(_ sender: UIButton) {
        appendDigits()
        var index : Int = 0
        var calculatedNumber : Double = 0
        print("All numbers: \(number)")
        // Equal sign touched with no numbers
        if number.count == 0 {
            resetValues()
        }
        // Equal sign touched with one digit selected
        else if number.count == 1 {
            numberText.text = String(number[0])
        }
        else {
            for i in 1...number.count-1 {
                if i == 1 {
                    print("\(number[i-1]) \(operationsStored[index]) \(number[i])")
                    calculatedNumber = executeCorrectOperation(operationsStored[index], number[i - 1], number[i])
                }
                else {
                    print("\(calculatedNumber) \(operationsStored[index]) \(number[i])")
                    calculatedNumber = executeCorrectOperation(operationsStored[index], calculatedNumber, number[i])
                }
                index += 1
                print("Calculated digits so far: \(calculatedNumber)")
            }
            
            numberText.text = String(calculatedNumber)
        }
        
        resetValues()
    }
    
    func executeCorrectOperation(_ operationType : String, _ digitOne : Double, _ digitTwo : Double) -> Double {
        var calculatedNumber : Double = 0
        if operationType == "add" {
            calculatedNumber = digitOne + digitTwo
        }
        else if operationType == "sub" {
            calculatedNumber = digitOne - digitTwo
        }
        else if operationType == "mul" {
            calculatedNumber = digitOne * digitTwo
        }
        else if operationType == "div" {
            calculatedNumber = digitOne / digitTwo
        }
        
        return calculatedNumber
    }
    
    func resetValues() {
        operationsStored.removeAll()
        number.removeAll()
        numberHolder = ""
        numberText.text = "0"
    }
    
    @IBAction func clearAction(_ sender: UIButton) {
        resetValues()
    }
}

