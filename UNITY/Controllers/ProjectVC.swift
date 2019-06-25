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
import CoreData


class ProjectVC: UIViewController, UITableViewDelegate, UITableViewDataSource, SwipeTableViewCellDelegate {
    
    // MARK: - class properties
    var projects = [Projects]()
    var completedTasks = [Tasks]()
    var myTasks = [Tasks]()
    var selectedProj: Projects?
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let profilePictureRef = Storage.storage().reference().child("new/\(Auth.auth().currentUser!.uid)")
    var loadedPicture = UIImage()
    
    
    
    // MARK: - Outlets
    @IBOutlet weak var addButton: RoundedPlusButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var profileSettingsButton: RoundedProfileButton!
    
    //MARK: - IBActions
    @IBAction func addButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "AddStuffVC", sender: self)
    }
    
    

    
    //MARK: - LifeCycle Methods
    
    override func viewDidLoad() {
        loadData()
        super.viewDidLoad()
        setupTableView()
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddStuffVC" {
        let destinationVC = segue.destination as? AddStuffVC
        destinationVC?.labelText = "Add Project"
            destinationVC?.dataCreationType = .Project
        } else if segue.identifier == "taskVC" {
            let destinationVC = segue.destination as? TaskVC
            destinationVC?.selectedProject = selectedProj
            
        }
    }
    
   
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        profileSettingsButton.subviews.first?.contentMode = .scaleAspectFill
        addButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 4, right: 0)
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        profileSettingsButton.setImage(getSavedImage(named: User.profilePicture), for: .normal)
        loadData()
        tableView.reloadData()
        
    }
    
    
    //MARK: - Database Methods / Setup
    
    func saveContext(){
        do {
            try context.save()
        } catch {
            print("error: \(error)")
        }
    }
    
    func loadData() {
        //Load Projects Array
            let request: NSFetchRequest<Projects> = Projects.fetchRequest()
    
            do {
                projects = try context.fetch(request)
                
            } catch {
                print("error fetching data : \(error)")
            }
        //Load Finished Tasks Array
            let request2: NSFetchRequest<Tasks> = Tasks.fetchRequest()
            request2.predicate = NSPredicate(format: "done == %@", NSNumber(booleanLiteral: true))
            do {
            completedTasks = try context.fetch(request2)
            } catch {
                print("error fetching data : \(error)")
                }
        
        // Load MyTasks Array
            let request3: NSFetchRequest<Tasks> = Tasks.fetchRequest()
            let myTasks1 = NSPredicate(format: "myTask == %@", NSNumber(booleanLiteral: true))
            let myTasks2 = NSPredicate(format: "done != %@", NSNumber(booleanLiteral: true))
            request3.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [myTasks1,myTasks2])
        do {
            myTasks = try context.fetch(request3)
        } catch {
            print("error fetching data : \(error)")
        }
    }

    
 
    //MARK: - TableView Methods
    
    fileprivate func setupTableView() {
        
        tableView.estimatedRowHeight = 200
        tableView.rowHeight = 70
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.reloadData()
    }

    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = .clear
        cell.contentView.backgroundColor = .clear
        cell.backgroundView = nil
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete
        {
        if indexPath.section == 0 {
            context.delete(self.myTasks[indexPath.row])
            self.myTasks.remove(at: indexPath.row)
            saveContext()
            tableView.reloadData()
        } else if indexPath.section == 1 {
            context.delete(self.projects[indexPath.row])
            self.projects.remove(at: indexPath.row)
            saveContext()
            tableView.reloadData()
        } else {
            context.delete(self.completedTasks[indexPath.row])
            self.completedTasks.remove(at: indexPath.row)
            saveContext()
            tableView.reloadData()
            }}
    }
    
    
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }
        
        let delete = SwipeAction(style: .destructive, title: nil) { (delete, indexPath) in
            
            if indexPath.section == 0 {
                self.context.delete(self.myTasks[indexPath.row])
            self.myTasks.remove(at: indexPath.row)
            } else if indexPath.section == 1 {
                //TODO: add segue to warning prompt "Project is about to be deleted would you like to continue?"
                self.context.delete(self.projects[indexPath.row])
                self.projects.remove(at: indexPath.row)
            } else {
                self.context.delete(self.completedTasks[indexPath.row])
                self.completedTasks.remove(at: indexPath.row)
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
  

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedProj = projects[indexPath.row]
        //TODO: look into this optional more to decide if I should use it.
        if indexPath.section == 1 {
        performSegue(withIdentifier: "taskVC", sender: self)
        } else if indexPath.section == 0 {
            myTasks[indexPath.row].done = true
            saveContext()
            
            loadData()
            tableView.reloadData()
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return myTasks.count
           
        } else if section == 1 {
            return projects.count
        
        } else {
            return completedTasks.count
      
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
            cell.taskName.text = myTasks[indexPath.row].taskName
            //TODO: add name of project/task here.
            cell.projectDueDate.text = "Jan 5" //myTasks[indexPath.row].dueDate
            cell.projectTeam.text = myTasks[indexPath.row].parentProject?.projectName
            return cell
            
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "projects", for: indexPath) as! ProjectsTableViewCell
            
            cell.delegate = self
            cell.contentView.backgroundColor = .clear
            tableView.backgroundColor = .clear
            cell.taskName.text = projects[indexPath.row].projectName
            cell.projectDueDate.text = "Jan 5" //myTasks[indexPath.row].dueDate
            cell.projectTeam.text = "team Name"
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "completed", for: indexPath) as! CompletedTableViewCell
            cell.delegate = self
            cell.contentView.backgroundColor = .clear
            tableView.backgroundColor = .clear
            cell.taskName.text = completedTasks[indexPath.row].taskName
            cell.projectDueDate.text = "Jan 5" //myTasks[indexPath.row].dueDate
            cell.projectTeam.text = completedTasks[indexPath.row].parentProject?.projectName
            return cell
        default:
            break
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "myTasks", for: indexPath)
        return cell
    }
    
    

    
    
}
