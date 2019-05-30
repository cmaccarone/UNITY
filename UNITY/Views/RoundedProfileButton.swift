//
//  RoundedProfileView.swift
//  UNITY
//
//  Created by Caleb Maccarone on 5/30/19.
//  Copyright © 2019 Caleb Maccarone. All rights reserved.
//

import UIKit

class RoundedProfileButton:UIButton {

    override func awakeFromNib() {
        setupView()
    }
    
    
    func setupView(){
        self.layer.cornerRadius = self.layer.frame.height / 2
        self.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.layer.borderWidth = 2
        self.layer.borderColor = #colorLiteral(red: 0, green: 0.7607843137, blue: 1, alpha: 1)

}
}
