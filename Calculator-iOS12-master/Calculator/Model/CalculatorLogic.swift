//
//  CalculatorLogic.swift
//  Calculator
//
//  Created by Ismail Elmaliki on 9/7/19
//

import Foundation

struct CalculatorLogic {
	
	private var number: Double?
	private var intermediateCalculation: (n1: Double, calcMethod: String)?
	private var numCount: Int = 0
	
	mutating func setNumber(_ number: Double) {
		self.number = number
	}
	
	// MARK: Calculate actions
	mutating func calculate(symbol: String) -> Double? {
		if let n = number {
			numCount += 1
			switch symbol {
			case "+/-":
				return n * -1
			case "AC":
				numCount = 0
				return 0
			case "%":
				return n / 100
			case "=":
				// 1 number selected then hitting '=' will display that number
				let result = checkSecondNum() ? performTwoNumCalculation(n2: n) : n
				return result
			default:
				intermediateCalculation = (n1: n, calcMethod: symbol)
			}
		}
			return nil
	}

	// MARK: performs arithmetic
	private func performTwoNumCalculation(n2: Double) -> Double? {
		if let n1 = intermediateCalculation?.n1, let operation = intermediateCalculation?.calcMethod {
			switch operation {
			case "+":
				return n1 + n2
			case "-":
				return n1 - n2
			case "×":
				return n1 * n2
			case "÷":
				return n1 / n2
			default:
				fatalError("The operation passed in does not match any of the cases.")
			}
		}
		
		return nil
	}
	
	// MARK: Determines if secondNumber is selected
	mutating private func checkSecondNum() -> Bool {
		if numCount <= 1 {
			numCount = 0
			return false
		}
		return true
	}
}
