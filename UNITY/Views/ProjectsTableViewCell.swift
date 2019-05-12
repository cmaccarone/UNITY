//
//  ProjectsTableViewCell.swift
//  UNITY
//
//  Created by Caleb Maccarone on 5/7/19.
//  Copyright © 2019 Caleb Maccarone. All rights reserved.
//

import UIKit
import SwipeCellKit

class ProjectsTableViewCell: SwipeTableViewCell {

    
    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var checkBox: UIButton!
    
    @IBOutlet weak var taskName: UILabel!
    @IBOutlet weak var projectDueDate: UILabel!
    @IBOutlet weak var projectTeam: UILabel!

    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        backView.layer.cornerRadius = 25
        backView.backgroundColor = #colorLiteral(red: 0.7137254902, green: 0.8901960784, blue: 0.5019607843, alpha: 1)
        self.backgroundColor = .clear
 
    
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
