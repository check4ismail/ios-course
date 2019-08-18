//
//  ViewController.swift
//  BitcoinTicker
//
//  Created by Angela Yu on 23/01/2016.
//  Copyright © 2016 London App Brewery. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
	
    let baseURL = "https://apiv2.bitcoinaverage.com/indices/global/ticker/BTC"
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
	let currencySymbols = ["$", "R$", "$", "¥", "€", "£", "$", "Rp", "₪", "₹", "¥", "$", "kr", "$", "zł", "lei", "₽", "kr", "$", "$", "R"]
	var currencyRowSelected = 0
    var finalURL = ""
	var bitCoinData = ""

    //Pre-setup IBOutlets
    @IBOutlet weak var bitcoinPriceLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
		
		currencyPicker.delegate = self
		currencyPicker.dataSource = self
    }
	
    //TODO: Place your 3 UIPickerView delegate methods here
	func numberOfComponents(in pickerView: UIPickerView) -> Int {
		return 1
	}
	
	func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
		return currencyArray.count
	}
	
	func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
		return currencyArray[row]
	}
	
	func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
		finalURL = baseURL + currencyArray[row]
		currencyRowSelected = row
		print(finalURL)
		getBitcoinCurrencyConversion(url: finalURL)
	}
    
	
    //MARK: - Networking
    /***************************************************************/
	
    func getBitcoinCurrencyConversion(url: String) {
		
		Alamofire.request(url, method: .get).validate().responseJSON {
			response in
			switch response.result {
			case .success:
				let bitCoinJSON : JSON = JSON(response.result.value!)
				print(bitCoinJSON)
				self.updateBitcoinCurrency(json: bitCoinJSON)
			case .failure(let error):
				print("Error \(error)")
			}
		}
    }
//
//    
//    
//    
//    
//    //MARK: - JSON Parsing
//    /***************************************************************/
//    
    func updateBitcoinCurrency(json : JSON) {
		
        if let tempResult = json["last"].double {
			bitcoinPriceLabel.text = "\(currencySymbols[currencyRowSelected])" + String(format:"%.2f", tempResult)
        }
		else {
			bitcoinPriceLabel.text = "Conversion unavailable"
		}
		
    }
	




}

