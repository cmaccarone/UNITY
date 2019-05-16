//
//  MyTasksTableViewCell.swift
//  UNITY
//
//  Created by Caleb Maccarone on 5/10/19.
//  Copyright © 2019 Caleb Maccarone. All rights reserved.
//

import UIKit
import SwipeCellKit

class MyTasksTableViewCell: SwipeTableViewCell {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var checkBox: UIButton!
    
    @IBOutlet weak var taskName: UILabel!
    @IBOutlet weak var projectDueDate: UILabel!
    @IBOutlet weak var projectTeam: UILabel!
    
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        backView.layer.cornerRadius = 25
        backView.backgroundColor = #colorLiteral(red: 0.4190315306, green: 0.5464963913, blue: 0.7911339402, alpha: 1)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
