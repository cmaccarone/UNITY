//
//  RoundedTextField.swift
//  UNITY
//
//  Created by Caleb Maccarone on 4/26/19.
//  Copyright © 2019 Caleb Maccarone. All rights reserved.
//
import Foundation
import UIKit

enum textFieldState {
    case selected
    case deselected
    case error
}

@IBDesignable
class RoundedTextField: UITextField {
    
    
    //inspectable variables with didsets
    @IBInspectable var cornerRadius : CGFloat = 50.0 {didSet { setupView() }}
    
   override func awakeFromNib() {
        setupView()
        self.borderStyle = .none
        self.layer.borderColor = #colorLiteral(red: 0.4666666667, green: 0.4666666667, blue: 0.4666666667, alpha: 1)
        self.layer.borderWidth = 1.5
        self.layer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.layer.opacity = 75
    
    }
    
    
    func setupView() {
        self.layer.cornerRadius = cornerRadius
        
}
    
 
    
}

    

