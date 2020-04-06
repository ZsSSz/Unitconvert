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
    
    @objc func toggleLength(srcObj: UISwitch) {
        lengthStatus = srcObj.isOn
        if lengthStatus {
            kmMlLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            mlKmLabel.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        } else {
            mlKmLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            kmMlLabel.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        }
        self.calcLength(srcObj: lengthValue)
    }
    
    @objc func toggleWeight(srcObj: UISwitch) {
        weightStatus = srcObj.isOn
        if weightStatus {
            kgLbLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            lbKgLabel.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        } else {
            kgLbLabel.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            lbKgLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }
        self.calcWeight(srcObj: weightValue)
    }
    
    @objc func calcLength(srcObj: UITextField) {
        var measure:String = " Ml"
        var lengthResult = 0.0
        if Double(srcObj.text!) == nil {
        lengthResultField.text = "Invalid value"
        return
        }
        let value = Double(srcObj.text!) ?? 0.0
        if value < 0 {
            lengthResultField.text = "Use a positive number!"
            return
        }
        
        if lengthStatus {
            lengthResult = value * 0.6214
        } else {
            lengthResult = value / 0.6214
            measure = " Km"
        }
        lengthResult = Double(round(lengthResult * 100) / 100)
        lengthResultField.text = String(lengthResult) + measure
        
    }

    @objc func calcWeight(srcObj: UITextField) {
        var measure:String = " Lb"
        var weightResult = 0.0
        if Double(srcObj.text!) == nil {
            weightResultField.text = "Invalid value"
            return
        }
        let value = Double(srcObj.text!) ?? 0.0
       
        if value < 0 {
            weightResultField.text = "Use a positive number!"
            return
        }
        if weightStatus {
            weightResult = value / 0.45359237
        } else {
            weightResult = value * 0.45359237
            measure = " Kg"
        }
        weightResult = Double(round(weightResult * 100) / 100)
        weightResultField.text = String(weightResult) + measure
    }

}

