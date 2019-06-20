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
    
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var profileSettingsButton: RoundedProfileButton!
    

    
    
    //Project VC cell array.
    let profilePictureName = "profilePic.png"
    let projects = [Project]()
    let tasks = [Task]()
    
    fileprivate func setupTableView() {
        
        tableView.estimatedRowHeight = 200
        tableView.rowHeight = 70
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.reloadData()
    }
    
    let profilePictureRef = Storage.storage().reference().child("new/\(Auth.auth().currentUser!.uid)")
    var loadedPicture = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        
        //loads profile picture
       profileSettingsButton.setImage(getSavedImage(named: profilePictureName) ?? #imageLiteral(resourceName: "ProfilePhoto"), for: .normal)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
       profileSettingsButton.subviews.first?.contentMode = .scaleAspectFill
    }
//    projects
    
    
    
    //tasks

    
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
     //       self.myTasks.remove(at: indexPath.row)
            tableView.reloadData()
        } else if indexPath.section == 1 {
     //       self.projects.remove(at: indexPath.row)
            tableView.reloadData()
        } else {
       //     self.completed.remove(at: indexPath.row)
            tableView.reloadData()
            }}
    }
    
    
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }
        
        let delete = SwipeAction(style: .destructive, title: nil) { (delete, indexPath) in
            
            if indexPath.section == 0 {
         //       self.myTasks.remove(at: indexPath.row)
            } else if indexPath.section == 1 {
                //TODO: add segue to warning prompt "Project is about to be deleted would you like to continue?"
         //       self.projects.remove(at: indexPath.row)
            } else {
          //      self.completed.remove(at: indexPath.row)
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
        
        return 0
       
    }
    
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "myTasks", for: indexPath) as! MyTasksTableViewCell
            cell.backgroundColor = .clear
            cell.delegate = self
            cell.contentView.backgroundColor = .clear
            tableView.backgroundColor = .clear
           // cell.taskName.text = myTasks[indexPath.row].name
            cell.projectDueDate.text = "Jan 5" //myTasks[indexPath.row].dueDate
            cell.projectTeam.text = "team Name"
            return cell
            
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "projects", for: indexPath) as! ProjectsTableViewCell
            
            cell.delegate = self
            cell.contentView.backgroundColor = .clear
            tableView.backgroundColor = .clear
           // cell.taskName.text = projects[indexPath.row].name
            cell.projectDueDate.text = "Jan 5" //myTasks[indexPath.row].dueDate
            cell.projectTeam.text = "team Name"
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "completed", for: indexPath) as! CompletedTableViewCell
            cell.delegate = self
            cell.contentView.backgroundColor = .clear
            tableView.backgroundColor = .clear
          //  cell.taskName.text = completed[indexPath.row].name
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
