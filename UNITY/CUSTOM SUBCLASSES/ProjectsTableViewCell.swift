//
//  ProjectsTableViewCell.swift
//  UNITY
//
//  Created by Caleb Maccarone on 5/7/19.
//  Copyright © 2019 Caleb Maccarone. All rights reserved.
//

import UIKit

class ProjectsTableViewCell: UITableViewCell {

    
    
    @IBOutlet weak var checkBox: UIImageView!
    @IBOutlet weak var taskName: UILabel!
    @IBOutlet weak var projectDueDate: UILabel!
    @IBOutlet weak var projectTeam: UILabel!
    @IBOutlet weak private var dividerLine: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = self.layer.frame.height/2
        self.layer.backgroundColor = #colorLiteral(red: 0.5764705882, green: 0.8823529412, blue: 0.5490196078, alpha: 1)
        dividerLine.layer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
