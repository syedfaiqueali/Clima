//
//  ViewController.swift
//  Clima
//
//  Created by Faiq on 13/12/2020.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController {
    
    //MARK:- IBOutlet
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    
    // Instance of WeatherManager
    var weatherManager = WeatherManager()
    // For accessing location
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        
        //Ask user's location permission
        locationManager.requestWhenInUseAuthorization()
        //Access user's current location
        locationManager.requestLocation()
        
        //Delegates
        weatherManager.delegate = self
        searchTextField.delegate = self
    }

}

//MARK:- SearchTextField delegate methods
extension WeatherViewController: UITextFieldDelegate {
    
    //MARK:- IBAction
    @IBAction func searchPressed(_ sender: UIButton) {
        //to dismiss the keyboard
        searchTextField.endEditing(true)
        
        print(searchTextField.text!)
    }
    
    //When user press 'Go' button from keyboard. So it act as a return keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //to dismiss the keyboard
        searchTextField.endEditing(true)
        
        print(searchTextField.text!)
        return true
    }
    
    //To check if the user has typed something or not and prompt the user if the search text field is empty
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != ""{
            return true
        } else {
            textField.placeholder = "Type something"
            return false
        }
    }
    
    //When user stops editing so clears previous text from search text field
    func textFieldDidEndEditing(_ textField: UITextField) {
        //guard let city = searchTextField.text else {return}
        
        if let city = searchTextField.text {
            weatherManager.fetchWeather(cityName: city)
        }
        searchTextField.text = ""
    }
}

//MARK:- Weather Manager Delegate
extension WeatherViewController: WeatherManagerDelegate {
    
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
        // Dispatch is necessary so that main thread is not blocked
        // and our UI doesnt get stucks
        DispatchQueue.main.async {
            self.temperatureLabel.text = weather.temperatureString
            self.conditionImageView.image = UIImage(systemName: weather.conditionName)
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}

//MARK:- CoreLocation Manager Delegate
extension WeatherViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //last - to get the most accurate
        if let location = locations.last {
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            print(lat,lon)
        }
        print("Got Location data")
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
