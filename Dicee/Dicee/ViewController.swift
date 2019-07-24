//
//  ViewController.swift
//  Dicee
//
//  Created by Ismail Elmaliki on 7/24/19.
//  Copyright © 2019 Ismail Elmaliki. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	var randomDiceIndex1: Int = 0;
	var randomDiceIndex2: Int = 0;
	
	@IBOutlet weak var diceImageView1: UIImageView!
	@IBOutlet weak var diceImageView2: UIImageView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		updateDiceImages()
	}

	@IBAction func rollButtonPressed(_ sender: UIButton) {
		// What happens when the Roll button is pressed
		updateDiceImages()
	}
	
	override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
		updateDiceImages()
	}
	
	func updateDiceImages() {
		// Randomly selects number between 0 and 5 (inclusively)
		randomDiceIndex1 = Int.random(in: 1 ... 6)
		randomDiceIndex2 = Int.random(in: 1 ... 6)
		
		diceImageView1.image = UIImage(named: "dice\(randomDiceIndex1)")
		diceImageView2.image = UIImage(named: "dice\(randomDiceIndex2)")
	}
}

