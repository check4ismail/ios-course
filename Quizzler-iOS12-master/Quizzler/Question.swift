//
//  Question.swift
//  Quizzler
//
//  Created by Ismail Elmaliki on 7/28/19.
//  Copyright © 2019 London App Brewery. All rights reserved.
//

import Foundation

class Question {
	
	// Properties of the question class
	let questionText : String
	let answer : Bool
	
	
	init(text: String, correctAnswer: Bool) {
		// initialization method for class (similar to constructor)
		questionText = text
		answer = correctAnswer
	}
}
