//
//  Tasks.swift
//  UNITY
//
//  Created by Caleb Maccarone on 5/1/19.
//  Copyright © 2019 Caleb Maccarone. All rights reserved.
//

import Foundation

struct Task: Hashable, Equatable {
  
    
    
    var name : String?
    var dueDate : Date?
    var reminderDate : Date?
    var reminderTime : String?
    var taskType : TaskType?
    var taskState : TaskStates?
    var identifier = UUID.init()
    var delegatedUsers:Array<User>
   
    static func == (lhs: Task, rhs: Task) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    
}
