//
//  AddStuffVC.swift
//  UNITY
//
//  Created by Caleb Maccarone on 6/19/19.
//  Copyright © 2019 Caleb Maccarone. All rights reserved.
//

import UIKit
import CoreData

class AddStuffVC: UIViewController {
    
    var selectedProject : Projects?
    var dataCreationType : AddType = .Project
    var labelText: String = "Add Task"
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var createButton: UIButton!
    @IBOutlet weak var myTask: UISwitch!
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    var projects = [Projects]()
    var tasks = [Tasks]()
    //properties
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboard()
        titleLabel.text = labelText
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBAction func createPushed(_ sender: Any) {
        
        switch dataCreationType {
        case .Project:
            let newProject = Projects(context: context)
            newProject.projectName = nameField.text
            saveContext()
        case .Task:
            let newTask = Tasks(context: context)
            newTask.taskName = nameField.text
            newTask.done = false
            newTask.setValue(selectedProject, forKey: "parentProject")
            print(newTask.parentProject)
            
            if myTask.isOn {
               newTask.myTask = true
            } else {
                newTask.myTask = false
            }
           saveContext()
        }
        
        
        nameField.text = ""
        //TODO: add a text label that says Task/Project Saved Successfully.. or prints the error if there is a problem
    }
    

    
    //Database Methods
    
    func saveContext(){
        do {
            try context.save()
        } catch {
            print("error: \(error)")
        }
    }
    
    
    
    
}

enum AddType {
    case Project
    case Task
}
