//
//  ViewController.swift
//  Xylophone
//
//  Created by Angela Yu on 27/01/2016.
//  Copyright © 2016 London App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController{
	
	var player: AVAudioPlayer!
	
    override func viewDidLoad() {
        super.viewDidLoad()
    }



    @IBAction func notePressed(_ sender: UIButton) {
		/*
			Let's us know which tag the user tapped on
			by printing out the tag
		*/
		playSound(sender.tag)
		print(sender.tag)
    }
    
	func playSound(_ tag: Int) {
		let xylophoneSound = Bundle.main.url(forResource: "note\(tag)", withExtension: "wav")!
		
		do {
			player = try AVAudioPlayer(contentsOf: xylophoneSound)
			player.prepareToPlay()
			player.play()
		}
		catch let error {
			print(error.localizedDescription)
		}
	}

}

