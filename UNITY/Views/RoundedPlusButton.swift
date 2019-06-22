//
//  RoundedPlusButton.swift
//  UNITY
//
//  Created by Caleb Maccarone on 5/7/19.
//  Copyright © 2019 Caleb Maccarone. All rights reserved.
//

import UIKit
@IBDesignable
class RoundedPlusButton: UIButton {

    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = self.layer.frame.height/2
        self.layer.backgroundColor = #colorLiteral(red: 0.7120720744, green: 0.8886485696, blue: 0.50163275, alpha: 1)
        self.layer.borderColor = #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)
        self.layer.borderWidth = 3
        
    }
}

