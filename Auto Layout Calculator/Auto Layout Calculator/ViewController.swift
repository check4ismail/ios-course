//
//  ViewController.swift
//  Auto Layout Calculator
//
//  Created by Ismail Elmaliki on 7/30/19.
//  Copyright © 2019 Ismail Elmaliki. All rights reserved.
//

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
		numberText.text = "0"
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
        number.append(Double(numberHolder)!)
        numberHolder = ""
    }
    
    @IBAction func executeOperations(_ sender: UIButton) {
        appendDigits()
        var index : Int = 0
        var calculatedNumber : Double = 0
        print("All numbers: \(number)")
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
    }
    
    
    @IBAction func clearAction(_ sender: UIButton) {
        resetValues()
        numberText.text = "0"
    }
}

