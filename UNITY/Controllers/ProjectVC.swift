//
//  ProjectVC.swift
//  UNITY
//
//  Created by Caleb Maccarone on 5/1/19.
//  Copyright © 2019 Caleb Maccarone. All rights reserved.
//

import UIKit
import Firebase
import SwipeCellKit
import FirebaseAuth


class ProjectVC: UIViewController, UITableViewDelegate, UITableViewDataSource, SwipeTableViewCellDelegate {
 
    

    @IBOutlet weak var tableView: UITableView!
    //filler data
    

    @IBAction func signOutPressed(_ sender: Any) {
                do {
                    try Auth.auth().signOut()
                } catch {
                    print(error)
                }
    }
    
    
    //Project VC cell array.
   
   
    
    fileprivate func setupTableView() {
        tableView.estimatedRowHeight = 200
        tableView.rowHeight = 70
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        setupTableView()
        
        
    }
    
    //projects
    
    var myProject = Project(name: "My Tasks")
    var officePro = Project(name: "Office Renovation")
    var marketingPro = Project(name: "Marketing")
    var accountingPro = Project(name: "Accounting")
    var webDev = Project(name: "Website Development")
    var appDev = Project(name: "App Development")
    var projects = [Project]()
    
    //tasks
    
    var task1 = Task(name: "Walk The Dog", dueDate: nil, reminderDate: nil, reminderTime: nil, taskType: .myTask, taskState: .incomplete, delegatedUsers: [nil])
    var task2 = Task(name: "take out trash", dueDate: nil, reminderDate: nil, reminderTime: nil, taskType: .myTask, taskState: .incomplete, delegatedUsers: [nil])
    var task3 = Task(name: "call Jerry", dueDate: nil, reminderDate: nil, reminderTime: nil, taskType: .myTask, taskState: .incomplete, delegatedUsers: [nil])
    var task4 = Task(name: "mail packages", dueDate: nil, reminderDate: nil, reminderTime: nil, taskType: .myTask, taskState: .completed, delegatedUsers: [nil])
    var task5 = Task(name: "go to store", dueDate: nil, reminderDate: nil, reminderTime: nil, taskType: .myTask, taskState: .completed, delegatedUsers: [nil])
    var task6 = Task(name: "buy lights", dueDate: nil, reminderDate: nil, reminderTime: nil, taskType: .myTask, taskState: .completed, delegatedUsers: [nil])
    var myTasks = [Task]()
    var completed = [Task]()
    
    // sample data for now.
    func loadData(){
        projects.append(myProject)
        projects.append(officePro)
        projects.append(marketingPro)
        projects.append(accountingPro)
        projects.append(webDev)
        projects.append(appDev)
        myTasks.append(task1)
        myTasks.append(task2)
        myTasks.append(task3)
        completed.append(task4)
        completed.append(task5)
        completed.append(task6)
    }
    
    //Mark: add project to projects array.
    func addProject() {
        
    }
    
    //Mark: Table View Delegate/Datasource
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = .clear
        cell.contentView.backgroundColor = .clear
        cell.backgroundView = nil
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete
        {
        if indexPath.section == 0 {
            self.myTasks.remove(at: indexPath.row)
            tableView.reloadData()
        } else if indexPath.section == 1 {
            self.projects.remove(at: indexPath.row)
            tableView.reloadData()
        } else {
            self.completed.remove(at: indexPath.row)
            tableView.reloadData()
            }}
    }
    
    
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }
        
        let delete = SwipeAction(style: .destructive, title: nil) { (delete, indexPath) in
            
            if indexPath.section == 0 {
                self.myTasks.remove(at: indexPath.row)
            } else if indexPath.section == 1 {
                //TODO: add segue to warning prompt "Project is about to be deleted would you like to continue?"
                self.projects.remove(at: indexPath.row)
            } else {
                self.completed.remove(at: indexPath.row)
            }
        }
        
        let settings = SwipeAction(style: .default, title: nil) { (settings, indexPath) in
            //TODO: add segue to settingsVC
        }
        delete.backgroundColor = .clear
        delete.image = #imageLiteral(resourceName: "DELETE ITEM BUTTON")
        settings.backgroundColor = .clear
        settings.image = #imageLiteral(resourceName: "Settings Item Button")
        return [delete,settings]
    }
  
    
    
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        var options = SwipeOptions()
        options.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        options.transitionStyle = .drag
        options.expansionStyle = .destructiveAfterFill
        options.maximumButtonWidth = 150
        options.minimumButtonWidth = 50
        return options
    }
    

    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionTitles = ["My Tasks","Projects","Completed"]
        let returnedView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 25))
        returnedView.backgroundColor = .clear
        
        let label = UILabel(frame: CGRect(x: 10, y: 7, width: tableView.frame.size.width, height: 25))
        label.text = sectionTitles[section]
        label.textColor = .white
        returnedView.addSubview(label)
        
        return returnedView
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let sectionTitles = ["My Tasks","Projects","Completed"]
    
        return sectionTitles[section]
    }
  

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return myTasks.count
        } else if section == 1 {
            return projects.count
        } else {
            return completed.count
        }
        
       
    }
    
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "myTasks", for: indexPath) as! MyTasksTableViewCell
            cell.backgroundColor = .clear
            cell.delegate = self
            cell.contentView.backgroundColor = .clear
            tableView.backgroundColor = .clear
            cell.taskName.text = myTasks[indexPath.row].name
            cell.projectDueDate.text = "Jan 5" //myTasks[indexPath.row].dueDate
            cell.projectTeam.text = "team Name"
            return cell
            
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "projects", for: indexPath) as! ProjectsTableViewCell
            
            cell.delegate = self
            cell.contentView.backgroundColor = .clear
            tableView.backgroundColor = .clear
            cell.taskName.text = projects[indexPath.row].name
            cell.projectDueDate.text = "Jan 5" //myTasks[indexPath.row].dueDate
            cell.projectTeam.text = "team Name"
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "completed", for: indexPath) as! CompletedTableViewCell
            cell.delegate = self
            cell.contentView.backgroundColor = .clear
            tableView.backgroundColor = .clear
            cell.taskName.text = completed[indexPath.row].name
            cell.projectDueDate.text = "Jan 5" //myTasks[indexPath.row].dueDate
            cell.projectTeam.text = "team Name"
            return cell
        default:
            break
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "myTasks", for: indexPath)
        return cell
    }
    
    

    
    
}
