//
//  ViewController.swift
//  WeatherApp
//
//  Created by Angela Yu on 23/08/2015.
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//

import UIKit
import CoreLocation // Used to determine core location for iOS
import Alamofire
import SwiftyJSON


class WeatherViewController: UIViewController, CLLocationManagerDelegate, ChangeCityDelegate {
	
    
    //Constants
    let WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather"
    let APP_ID = "76f0e7cec51fcf5ccee61d08502a18ce"
    /***Get your own App ID at https://openweathermap.org/appid ****/
    

    //TODO: Declare instance variables here
    let locationManager = CLLocationManager()
	let weatherDataModel = WeatherDataModel()

    
    //Pre-linked IBOutlets
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //TODO:Set up the location manager here.
    	locationManager.delegate = self
		locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
		locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    
    
    //MARK: - Networking
    /***************************************************************/
    
    //Write the getWeatherData method here:
	func getWeatherData(url: String, parameters: [String:String]) {
		Alamofire.request(url, method: .get, parameters: parameters).validate().responseJSON {
			response in
			switch response.result {
				case .success:
					print("Success! Got the weather data")
					let weatherJSON : JSON = JSON(response.result.value!)
					self.updateWeatherData(json: weatherJSON)
				case .failure(let error):
					print("Error \(error)")
					self.cityLabel.text = "Weather unavailable"
			}
		}
	}

    
    
    
    
    
    //MARK: - JSON Parsing
    /***************************************************************/
   
    
    //Write the updateWeatherData method here:
	func updateWeatherData(json : JSON) {
		let tempResult = json["main"]["temp"].double
		
		// Endpoint returns Kelvins. Calculations below convert to Farenheit
		weatherDataModel.temperature = Int(1.8 * (tempResult! - 273.15) + 32)
		weatherDataModel.city = json["name"].stringValue
		weatherDataModel.condition = json["weather"][0]["id"].intValue
		weatherDataModel.weatherIconName = weatherDataModel.updateWeatherIcon(condition: weatherDataModel.condition)
		updateUIWithWeatherData()
	}

    
    
    
    //MARK: - UI Updates
    /***************************************************************/
    
    
    //Write the updateUIWithWeatherData method here:
	
	func updateUIWithWeatherData() {
		cityLabel.text = weatherDataModel.city
		temperatureLabel.text = String(weatherDataModel.temperature)
		weatherIcon.image = UIImage(named: weatherDataModel.weatherIconName)
	}
    
    
    
    
    
    //MARK: - Location Manager Delegate Methods
    /***************************************************************/
    
    
    //Write the didUpdateLocations method here:
	func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		let location = locations[locations.count - 1]
		if location.horizontalAccuracy > 0 {
			locationManager.stopUpdatingLocation()
			locationManager.delegate = nil
			
			print("Longitute = \(location.coordinate.longitude), Latitude = \(location.coordinate.latitude)")
			let latitude = String(location.coordinate.latitude)
			let longitute = String(location.coordinate.longitude)
			
			let params : [String : String] = ["lat" : latitude, "lon" : longitute, "appid" : APP_ID]
			getWeatherData(url: WEATHER_URL, parameters: params)
		}
	}
    
    
    //Write the didFailWithError method here:
	func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
		print(error)
		cityLabel.text = "Location unavailable"
	}
    
    

    
    //MARK: - Change City Delegate methods
    /***************************************************************/
    
    
    //Write the userEnteredANewCityName Delegate method here:
	func userEnteredANewCityName(city: String) {
		print(city)
	}

    
    //Write the PrepareForSegue Method here
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "changeCityName" {
			let destinationVC = segue.destination as! ChangeCityViewController
			destinationVC.delegate = self
		}
	}
    
    
    
    
}


