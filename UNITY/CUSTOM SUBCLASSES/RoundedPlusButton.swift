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
        self.layer.backgroundColor = #colorLiteral(red: 0.5764705882, green: 0.8823529412, blue: 0.5490196078, alpha: 1)
    
    }
}
