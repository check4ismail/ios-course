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
		if numberHolder == "" {
			return
		}
		
		operationSelected = true
		number.append(Double(numberHolder)!)
		numberHolder = ""
		
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
	
	
	@IBAction func executeOperations(_ sender: UIButton) {
		for i in 0..<operationsStored.count(by:2) {
			
		}
	}
	
	func numToString(_ number : Int) {
		
	}
	
	func numToString(_ number : Double) {
		
	}
}

