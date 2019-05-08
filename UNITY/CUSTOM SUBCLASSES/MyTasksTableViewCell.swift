//
//  MyTasksTableViewCell.swift
//  UNITY
//
//  Created by Caleb Maccarone on 5/7/19.
//  Copyright © 2019 Caleb Maccarone. All rights reserved.
//

import UIKit

class MyTasksTableViewCell: UITableViewCell {

    //Outlets
    @IBOutlet weak var checkBox: UIImageView!
    @IBOutlet weak private var dividerLine: UIView!
    @IBOutlet weak var taskName: UILabel!
    @IBOutlet weak var projectDueDate: UILabel!
    @IBOutlet weak var projectName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = self.layer.frame.height/2
        self.layer.backgroundColor = #colorLiteral(red: 0.3529411765, green: 0.5921568627, blue: 0.831372549, alpha: 1)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
