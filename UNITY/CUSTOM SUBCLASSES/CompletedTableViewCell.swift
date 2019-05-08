//
//  CompletedTableViewCell.swift
//  UNITY
//
//  Created by Caleb Maccarone on 5/7/19.
//  Copyright © 2019 Caleb Maccarone. All rights reserved.
//

import UIKit

class CompletedTableViewCell: UITableViewCell {

    @IBOutlet weak var checkBox: UIImageView!
    @IBOutlet weak var taskName: UILabel!
    @IBOutlet weak var taskCompletedDate: UILabel!
    @IBOutlet weak var completedByText: UILabel!
    @IBOutlet weak private var dividingLine: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = self.layer.frame.height/2
        self.layer.backgroundColor = #colorLiteral(red: 0.5764705882, green: 0.8823529412, blue: 0.5490196078, alpha: 0)
        self.layer.borderColor = #colorLiteral(red: 0.5764705882, green: 0.8823529412, blue: 0.5490196078, alpha: 1)
        self.layer.borderWidth = 1.0
        dividingLine.layer.backgroundColor = #colorLiteral(red: 0.5764705882, green: 0.8823529412, blue: 0.5490196078, alpha: 1)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
