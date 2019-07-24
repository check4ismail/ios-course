//
//  ViewController.swift
//  Magic 8 Ball
//
//  Created by Ismail Elmaliki on 7/24/19.
//  Copyright © 2019 Ismail Elmaliki. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	@IBOutlet weak var imageView: UIImageView!
	var randomNumber : Int = 0
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		newBallImage()
	}

	@IBAction func askButtonPressed(_ sender: UIButton) {
		newBallImage()
	}
	
	override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
		newBallImage()
	}
	
	func newBallImage() {
		randomNumber = Int.random(in: 1 ... 5)
		imageView.image = UIImage(named: "ball\(randomNumber)")
	}
}

