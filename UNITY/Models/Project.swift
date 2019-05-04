//
//  Project.swift
//  UNITY
//
//  Created by Caleb Maccarone on 5/1/19.
//  Copyright © 2019 Caleb Maccarone. All rights reserved.
//

import Foundation




struct Project {
    //class variables
    var name : String?
    var dueDate : Date?
    var tasks = [Task?]()
    
    mutating func addTask(task:Task) {
        tasks.append(task)
    }
    
    mutating func removeTask(task:Task) {
        if let indexOfItem = tasks.firstIndex(of: task) {
        tasks.remove(at: indexOfItem)
        }
    }
    
    //Initializer
    init(name: String?) {
    self.name = name
    }
}
