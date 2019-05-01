//
//  Tasks.swift
//  UNITY
//
//  Created by Caleb Maccarone on 5/1/19.
//  Copyright © 2019 Caleb Maccarone. All rights reserved.
//

import Foundation

struct Tasks {
    
    var name : String?
    var dueDate : Date?
    var reminderDate : Date?
    var reminderTime : String?
   
    init(name: String?,dueDate: Date?,reminderDate: Date?,reminderTime: String?){
        self.name = name
        self.dueDate = dueDate
        self.reminderDate = reminderDate
        self.reminderTime = reminderTime
    }
    
    
}
