//
//  ViewController.swift
//  UnitConvert
//
//  Created by Zsuzsanna Seredi on 01/04/2020.
//  Copyright © 2020 Zsuzsanna Seredi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
    @IBOutlet weak var weightResultField: UILabel!
    @IBOutlet weak var lengthResultField: UILabel!
    
    @IBOutlet weak var lengthSwitch: UISwitch!
    @IBOutlet weak var weightSwitch: UISwitch!
    
    @IBOutlet weak var mlKmLabel: UILabel!
    @IBOutlet weak var kmMlLabel: UILabel!
    
    @IBOutlet weak var lbKgLabel: UILabel!
    @IBOutlet weak var kgLbLabel: UILabel!
    
    @IBOutlet weak var weightValue: UITextField!
    @IBOutlet weak var lengthValue: UITextField!
    
    var lengthStatus:Bool = true
    var weightStatus:Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lengthSwitch.addTarget(self, action: #selector(toggleLength), for: UIControl.Event.valueChanged)
        kmMlLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        weightSwitch.addTarget(self, action: #selector(toggleWeight), for: UIControl.Event.valueChanged)
           kgLbLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        lengthValue.addTarget(self, action: #selector(calcLength), for: UIControl.Event.editingChanged)
        weightValue.addTarget(self, action: #selector(calcWeight), for: UIControl.Event.editingChanged)
    }
    
    func changeTextColor(status: Bool, label1: UILabel, label2: UILabel) {
        if status {
            label1.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            label2.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        } else {
            label1.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            label2.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        }
    }
    
    @objc func toggleLength(srcObj: UISwitch) {
        lengthStatus = srcObj.isOn
        self.changeTextColor(status: lengthStatus, label1: kmMlLabel, label2: mlKmLabel)
        self.calcLength(srcObj: lengthValue)
    }
    
    @objc func toggleWeight(srcObj: UISwitch) {
        weightStatus = srcObj.isOn
        self.changeTextColor(status: weightStatus, label1: kgLbLabel, label2: lbKgLabel)
        self.calcWeight(srcObj: weightValue)
    }
    
    func isNumberValid(inputText: String?, value: Double, label: UILabel) -> Bool {
        if (inputText != "") && Double(inputText!) == nil {
            label.text = "Invalid value!"
            return false
        }
        if value < 0 {
            label.text = "Use a positive number!"
            return false
        }
        if value >= 100000000000000.00 {
            label.text = "Number is too large!"
            return false
        }
        return true
    }
    
    func mathOperation(status: Bool, value: Double, number:Double) -> Double {
        var result = 0.0
        if status {
            result = value * number
        } else {
            result = value / number
        }
        //For readability I rounded up the number, and only display it till the second decimal place.
        return(Double(round(result * 100) / 100))
    }
    
    @objc func calcLength(srcObj: UITextField) {
        let value = Double(srcObj.text!) ?? 0.0
        if !self.isNumberValid(inputText: srcObj.text, value: value, label: lengthResultField) {
            return
        }
        let lengthResult = self.mathOperation(status: lengthStatus, value: value, number: 0.6214)
        let measure = lengthStatus ? " Ml" : " Km"
        lengthResultField.text = String(lengthResult) + measure
        
    }

    @objc func calcWeight(srcObj: UITextField) {
        let value = Double(srcObj.text!) ?? 0.0
        if !isNumberValid(inputText: srcObj.text, value: value, label: weightResultField) {
            return
        }
        // From a design point of view and for simplicity sake, I wanted to use one function- mathOperation- to calculate the distance and weight. Because I didn't want to swap "Lb to Kg" and "Kg to Lb" on my screen, I decided to use 0.45359237 reciprocal which is (1 / 0.45359237) = 2.20462262185 this way I could keep the design as I like it, and use only one function for this operation.
        let weightResult = mathOperation(status: weightStatus, value: value, number: 2.20462262185)
        let measure = weightStatus ? " Lbs" : " Kg"
        weightResultField.text = String(weightResult) + measure
    }
}

