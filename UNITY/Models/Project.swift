//
//  Project.swift
//  UNITY
//
//  Created by Caleb Maccarone on 5/1/19.
//  Copyright © 2019 Caleb Maccarone. All rights reserved.
//

import Foundation




struct Project {
    
    var name : String?
    var dueDate : Date?
    var tasks = [Tasks]()
    
    init(name: String?, dueDate: Date?,tasks: [Tasks] ) {
    self.name = name
    self.dueDate = dueDate
    self.tasks = tasks
    }
}
