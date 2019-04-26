//
//  RoundedButton.swift
//  UNITY
//
//  Created by Caleb Maccarone on 4/26/19.
//  Copyright © 2019 Caleb Maccarone. All rights reserved.
//

import UIKit
@IBDesignable
class RoundedButton: UIButton {

    //vars
    @IBInspectable var cornerRadius:CGFloat = 0.0 {didSet{setupView()}}
    
    override func awakeFromNib() {
        setupView()
        
        

    }

    
    func setupView(){
        self.layer.cornerRadius = cornerRadius
        self.layer.backgroundColor = #colorLiteral(red: 0.431372549, green: 0.4666666667, blue: 0.5058823529, alpha: 1)
        self.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
    
}
