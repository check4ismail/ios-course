//
//  ViewController.swift
//  Segues
//
//  Created by Ismail Elmaliki on 8/15/19.
//  Copyright © 2019 Ismail Elmaliki. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	@IBOutlet weak var textField: UITextField!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
	}

	// Have a segue occur by click of button
	@IBAction func buttonPressed(_ sender: Any) {
		performSegue(withIdentifier: "goToSecondScreen", sender: self)
	}
	
	
	// This method allows you to prepare data in advance
	// before transitioning to second segue
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "goToSecondScreen" {
			
			// Creating constant object of SecondViewController
			let destinationVC = segue.destination as! SecondViewController
			destinationVC.textPassedOver = textField.text!
		}
	}
}

