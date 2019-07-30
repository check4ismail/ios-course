//
//  ViewController.swift
//  Destini
//
//  Created by Philipp Muellauer on 01/09/2015.
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // Our strings
    let story1 = "Your car has blown a tire on a winding road in the middle of nowhere with no cell phone reception. You decide to hitchhike. A rusty pickup truck rumbles to a stop next to you. A man with a wide brimmed hat with soulless eyes opens the passenger door for you and asks: \"Need a ride, boy?\"."
    let answer1a = "I\'ll hop in. Thanks for the help!"
    let answer1b = "Better ask him if he\'s a murderer first."
    
    
    let story2 = "He nods slowly, unphased by the question."
    let answer2a = "At least he\'s honest. I\'ll climb in."
    let answer2b = "Wait, I know how to change a tire."
    
    let story3 = "As you begin to drive, the stranger starts talking about his relationship with his mother. He gets angrier and angrier by the minute. He asks you to open the glovebox. Inside you find a bloody knife, two severed fingers, and a cassette tape of Elton John. He reaches for the glove box."
    let answer3a = "I love Elton John! Hand him the cassette tape."
    let answer3b = "It\'s him or me! You take the knife and stab him."
    
    let story4 = "What? Such a cop out! Did you know traffic accidents are the second leading cause of accidental death for most adult age groups?"
    let story5 = "As you smash through the guardrail and careen towards the jagged rocks below you reflect on the dubious wisdom of stabbing someone while they are driving a car you are in."
    let story6 = "You bond with the murderer while crooning verses of \"Can you feel the love tonight\". He drops you off at the next town. Before you go he asks you if you know any good places to dump bodies. You reply: \"Try the pier.\""
    
    
    // UI Elements linked to the storyboard
    @IBOutlet weak var topButton: UIButton!         // Has TAG = 1
    @IBOutlet weak var bottomButton: UIButton!      // Has TAG = 2
    @IBOutlet weak var storyTextView: UILabel!
    
    // TODO Step 5: Initialise instance variables here
    var currentStory : Int = 1
    
	override var preferredStatusBarStyle: UIStatusBarStyle {
		return .lightContent
	}
	
	override func viewDidAppear(_ animated: Bool) {
		navigationController?.navigationBar.barStyle = .black
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
	
        
        // TODO Step 3: Set the text for the storyTextView, topButton, bottomButton, and to T1_Story, T1_Ans1, and T1_Ans2
		updateTexts(answer1a, answer1b, story1)
    }

    
    // User presses one of the buttons
    @IBAction func buttonPressed(_ sender: UIButton) {
		
		if sender.tag == 1 {
			if topButton.currentTitle == answer1a {
				updateTexts(answer3a, answer3b, story3)
			}
			else if topButton.currentTitle == answer3a {
				updateTexts("", "", story6)
			}
			else if topButton.currentTitle == answer2a {
				updateTexts(answer3a, answer3b, story3)
			}
		}
		else if sender.tag == 2 {
			if bottomButton.currentTitle == answer1b {
				updateTexts(answer2a, answer2b, story2)
			}
			else if bottomButton.currentTitle == answer3b {
				updateTexts("", "", story5)
			}
			else if bottomButton.currentTitle == answer2b {
				updateTexts("", "", story4)
			}
		}
        // TODO Step 4: Write an IF-Statement to update the views
                
        // TODO Step 6: Modify the IF-Statement to complete the story
        
    
    }
	
	func updateTexts(_ newTitleButton1 : String, _ newTitleButton2 : String, _ newTextStoryLabel : String) {
		
		if newTextStoryLabel == story5 || newTextStoryLabel == story6 || newTextStoryLabel == story4 {
			topButton.isHidden = true
			bottomButton.isHidden = true
		}
		else {
			topButton.setTitle("\(newTitleButton1)", for: .normal)
			bottomButton.setTitle("\(newTitleButton2)", for: .normal)
		}
		storyTextView.text = newTextStoryLabel
	}
    



}

