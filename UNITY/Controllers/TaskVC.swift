//
//  TaskVC.swift
//  UNITY
//
//  Created by Caleb Maccarone on 6/22/19.
//  Copyright © 2019 Caleb Maccarone. All rights reserved.
//

import UIKit
import Firebase
import SwipeCellKit
import FirebaseAuth
import CoreData

class TaskVC: UIViewController, UITableViewDelegate, UITableViewDataSource, SwipeTableViewCellDelegate {
    
    //MARK: - Class Properties
    var myTasks = [Tasks]()
    var tasks = [Tasks]()
    var completedTasks = [Tasks]()
    
    var selectedProject: Projects? {didSet {loadData()}}
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    private let profilePictureRef = Storage.storage().reference().child("new/\(Auth.auth().currentUser!.uid)")
    private var loadedPicture = UIImage()
    // TODO: add data model that will hold task objects
    // var tasks = [Task]()
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var addButton: RoundedPlusButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var profileSettingsButton: RoundedProfileButton!
    
    //MARK: - IBActions
    
    @IBAction func backPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    

    
    //MARK: - LifeCycle Methods
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as? AddStuffVC
        destinationVC?.labelText = "Add Task"
        destinationVC?.dataCreationType = .Task
        destinationVC?.selectedProject = selectedProject
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboard()
        titleLabel.text = selectedProject?.projectName?.uppercased()
        loadData()
        setupTableView()
        
        
    }
    
    override func viewWillLayoutSubviews() {
        profileSettingsButton.subviews.first?.contentMode = .scaleAspectFill
        addButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 4, right: 0)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        profileSettingsButton.setImage(getSavedImage(named: User.profilePicture), for: .normal)
        loadData()
        tableView.reloadData()
        
    }
   
    
    //MARK: - Database Methods
    
    func saveContext(){
        do {
            try context.save()
        } catch {
            print("error: \(error)")
        }
        tableView.reloadData()
    }
    
    func loadData() {
        //Load Projects Array
        let request: NSFetchRequest<Tasks> = Tasks.fetchRequest()
        let tasks1 = NSPredicate(format: "myTask != %@", NSNumber(booleanLiteral: true))
        let tasks2 = NSPredicate(format: "done != %@", NSNumber(booleanLiteral: true))
        let tasks3 = NSPredicate(format: "parentProject.projectName == %@", selectedProject!.projectName!)
        let compound = NSCompoundPredicate(andPredicateWithSubpredicates: [tasks1, tasks2,tasks3])
        request.predicate = compound
        do {
        tasks = try context.fetch(request)
        } catch {
            print("error fetching data : \(error)")
        }
        //Load Finished Tasks Array
        let request2: NSFetchRequest<Tasks> = Tasks.fetchRequest()
        let task = NSPredicate(format: "done == %@", NSNumber(booleanLiteral: true))
        let task2 = NSPredicate(format: "parentProject.projectName == %@", selectedProject!.projectName!)
        let compound0 = NSCompoundPredicate(andPredicateWithSubpredicates: [task, task2])
        request2.predicate = compound0
        do {
            completedTasks = try context.fetch(request2)
        } catch {
            print("error fetching data : \(error)")
        }
        
        // Load MyTasks Array
        let request3: NSFetchRequest<Tasks> = Tasks.fetchRequest()
        let myTasks = NSPredicate(format: "myTask = %@", NSNumber(booleanLiteral: true))
        let myTasks2 = NSPredicate(format: "done != %@", NSNumber(booleanLiteral: true))
        let mytasks4 = NSPredicate(format: "parentProject.projectName == %@", selectedProject!.projectName!)
        let compound2 = NSCompoundPredicate(andPredicateWithSubpredicates: [myTasks, myTasks2,mytasks4])
        request3.predicate = compound2
        do {
            self.myTasks = try context.fetch(request3)
            
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
            context.delete(myTasks[indexPath.row])
            self.myTasks.remove(at: indexPath.row)
                tableView.reloadData()
            } else if indexPath.section == 1 {
                context.delete(tasks[indexPath.row])
                self.tasks.remove(at: indexPath.row)
                tableView.reloadData()
            } else {
                context.delete(completedTasks[indexPath.row])
                self.completedTasks.remove(at: indexPath.row)
                tableView.reloadData()
            }}
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            myTasks[indexPath.row].setValue(true, forKey: "done")
            myTasks.remove(at: indexPath.row)
            saveContext()
            loadData()
            tableView.reloadData()
            
        } else if indexPath.section == 1 {
            tasks[indexPath.row].setValue(true, forKey: "done")
            tasks.remove(at: indexPath.row)
            saveContext()
            loadData()
            tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }
        
        let delete = SwipeAction(style: .destructive, title: nil) { (delete, indexPath) in
            
            if indexPath.section == 0 {
                self.context.delete(self.myTasks[indexPath.row])
                self.myTasks.remove(at: indexPath.row)
            } else if indexPath.section == 1 {
                //TODO: add segue to warning prompt "Project is about to be deleted would you like to continue?"
                self.context.delete(self.tasks[indexPath.row])
                self.tasks.remove(at: indexPath.row)
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return myTasks.count

        } else if section == 1 {
            return tasks.count
           
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
            cell.projectDueDate.text = "Jan 5" //myTasks[indexPath.row].dueDate
            cell.projectTeam.text = "team Name"
            return cell
            
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "projects", for: indexPath) as! ProjectsTableViewCell
            
            cell.delegate = self
            cell.contentView.backgroundColor = .clear
            tableView.backgroundColor = .clear
            cell.taskName.text = tasks[indexPath.row].taskName
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
            cell.projectTeam.text = "team Name"
            return cell
        default:
            break
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "myTasks", for: indexPath)
        return cell
    }
    
    
    
    
    
}
