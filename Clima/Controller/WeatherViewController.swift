//
//  ViewController.swift
//  Clima
//
//  Created by Faiq on 13/12/2020.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController, UITextFieldDelegate, WeatherManagerDelegate {
    
    //MARK:- IBOutlet
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    
    // Instance of WeatherManager
    var weatherManager = WeatherManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        weatherManager.delegate = self
        
        //to allow textfield delegate methods
        searchTextField.delegate = self
    }

    //MARK:- IBAction
    @IBAction func searchPressed(_ sender: UIButton) {
        //to dismiss the keyboard
        searchTextField.endEditing(true)
        
        print(searchTextField.text!)
    }
    
    //MARK:- SearchTextField delegate methods
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
    
    //MARK:- Weather Manager Delegate
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

