//
//  CompletedTableViewCell.swift
//  UNITY
//
//  Created by Caleb Maccarone on 5/10/19.
//  Copyright © 2019 Caleb Maccarone. All rights reserved.
//

import UIKit

class CompletedTableViewCell: UITableViewCell {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var checkBox: UIButton!
    
    @IBOutlet weak var taskName: UILabel!
    @IBOutlet weak var projectDueDate: UILabel!
    @IBOutlet weak var projectTeam: UILabel!
    
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        backView.layer.cornerRadius = 25
        backView.backgroundColor = .clear
        backView.layer.borderColor = #colorLiteral(red: 0.7137254902, green: 0.8901960784, blue: 0.5019607843, alpha: 1)
        backView.layer.borderWidth = 1
        checkBox.setImage(#imageLiteral(resourceName: "Checkbox_checked"), for: .normal)
        self.backgroundColor = .clear
        
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
