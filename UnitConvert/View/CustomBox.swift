//
//  CustomBox.swift
//  UnitConvert
//
//  Created by Zsuzsanna Seredi on 02/04/2020.
//  Copyright © 2020 Zsuzsanna Seredi. All rights reserved.
//

import UIKit

@IBDesignable
class CustomBox: UIView {
    
    override func prepareForInterfaceBuilder() {
        customizeView()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        customizeView()
    }
    
    func customizeView () {
        layer.cornerRadius = 10.0
        layer.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.7977002641)
    }
}
