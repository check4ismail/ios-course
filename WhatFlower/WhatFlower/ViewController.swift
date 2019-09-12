//
//  ViewController.swift
//  WhatFlower
//
//  Created by Ismail Elmaliki on 9/11/19.
//  Copyright © 2019 Ismail Elmaliki. All rights reserved.
//

import UIKit
import CoreML
import Vision
import Alamofire
import SwiftyJSON

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

	@IBOutlet weak var textLabel: UILabel!
	@IBOutlet weak var imageView: UIImageView!
	let imagePicker = UIImagePickerController()
	let wikipediaURL = "https://en.wikipedia.org/w/api.php"
	var parametersRequest : [String:String] = [
		"format" : "json",
		"action" : "query",
		"prop" : "extracts",
		"exintro" : "",
		"explaintext" : "",
		"titles" : "",
		"indexpageids" : "",
		"redirects" : "1",
	]
	var flowerSummary: String = ""
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		imagePicker.delegate = self
		imagePicker.sourceType = .camera
		imagePicker.allowsEditing = true
		
	}

	func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
		
		if let userPickedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
			imageView.image = userPickedImage
			
			guard let ciimage = CIImage(image: userPickedImage) else {
				fatalError("Could not convert to CIImage")
			}
			
			detect(flowerImage: ciimage)
		}
	
		imagePicker.dismiss(animated: true, completion: nil)
	}
	
	func detect(flowerImage: CIImage) {
		guard let model = try? VNCoreMLModel(for: FlowerClassifier().model) else {
			fatalError("Loading CoreML model failed")
		}
		
		let request = VNCoreMLRequest(model: model) { (request, error) in
			guard let results = request.results as? [VNClassificationObservation] else {
				fatalError("VNClassificationObservation failed")
			}
			print("RESULTS: \(results)")
			if let firstResult = results.first {
				self.navigationItem.title = firstResult.identifier.capitalized
				self.parametersRequest["titles"] = firstResult.identifier.capitalized
				self.getFlowerInfo()
			}
		}
		
		let handler = VNImageRequestHandler(ciImage: flowerImage)
		
		do {
			// Calls handler to process photo
			try handler.perform([request])
		} catch {
			print(error)
		}
	}
	
	@IBAction func cameraPressed(_ sender: UIBarButtonItem) {
		present(imagePicker, animated: true, completion: nil)
	}
	
	func getFlowerInfo() {
		Alamofire.request(wikipediaURL, parameters: parametersRequest)
						.validate().responseJSON { response in
			
			switch response.result {
			case .success(let value):
				let json = JSON(value)
				let pageNumber = json["query","pageids",0]
				let summary = json["query","pages","\(pageNumber)","extract"]
//				print("JSON: \(json)")
//				print("pageNumber: \(pageNumber)")
				print("Summary: \(summary)")
				OperationQueue.main.addOperation {
					self.textLabel.text = summary.stringValue
				}
//				self.flowerSummary = summary.stringValue
			case .failure(let error):
				print(error)
			}
		}
	}
	
}

