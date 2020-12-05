//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController, UITextFieldDelegate {

    //MARK:- IBOutlet
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        searchTextField.text = ""
    }
}

