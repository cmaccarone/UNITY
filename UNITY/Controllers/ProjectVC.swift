//
//  ProjectVC.swift
//  UNITY
//
//  Created by Caleb Maccarone on 5/1/19.
//  Copyright © 2019 Caleb Maccarone. All rights reserved.
//

import UIKit

class ProjectVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    //filler data
    

    
    //Project VC cell array.
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        
        
    }
    
    var myTasks = Project(name: "My Tasks")
    var officePro = Project(name: "Office Renovation")
    var marketingPro = Project(name: "Marketing")
    var accountingPro = Project(name: "Accounting")
    var webDev = Project(name: "Website Development")
    var appDev = Project(name: "App Development")
    var projects = [Project]()
    
    
    // sample data for now.
    func loadData(){
        projects.append(myTasks)
        projects.append(officePro)
        projects.append(marketingPro)
        projects.append(accountingPro)
        projects.append(webDev)
        projects.append(appDev)
    }
    
    //Mark: add project to projects array.
    func addProject() {
        
    }
    
    //Mark: Table View Delegate/Datasource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return projects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "completed", for: indexPath)
        cell.detailTextLabel?.text = projects[indexPath.row].name
        if let cell = cell as? CompletedTableViewCell {
        
            
            return cell
        } else { return cell }
    
    }

    
    
}
