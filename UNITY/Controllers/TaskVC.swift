//
//  TaskVC.swift
//  UNITY
//
//  Created by Caleb Maccarone on 6/19/19.
//  Copyright © 2019 Caleb Maccarone. All rights reserved.
//

import UIKit
import SwipeCellKit

class TaskVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "myTasks", for: indexPath) as! MyTasksTableViewCell
        cell.backgroundColor = .clear
        
        cell.contentView.backgroundColor = .clear
        tableView.backgroundColor = .clear
        // cell.taskName.text = myTasks[indexPath.row].name
        cell.projectDueDate.text = "Jan 5" //myTasks[indexPath.row].dueDate
        cell.projectTeam.text = "team Name"
        return cell
        
    }
    
    
    
    let tasks = [Task]()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    
    //Mark: Datasource/Delegate Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
  
    
  
    
    

}
