//
//  AddStuffVC.swift
//  UNITY
//
//  Created by Caleb Maccarone on 6/19/19.
//  Copyright © 2019 Caleb Maccarone. All rights reserved.
//

import UIKit

class AddStuffVC: UIViewController {

    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var createButton: UIButton!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    //properties
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func createPushed(_ sender: Any) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            let newProject = Project(context: DataService.shared.context)
            if nameField.text != "" {
            newProject.name = nameField.text
            DispatchQueue.global(qos: .userInteractive).async {
                DataService.shared.saveData()
                }}
        case 1:
            let newTask = Project(context: DataService.shared.context)
            if nameField.text != "" {
                newTask.name = nameField.text
                DispatchQueue.global(qos: .userInteractive).async {
                    DataService.shared.saveData()
                }}
        default:
            return
        }
        
        nameField.text = ""
    }
    
    @IBAction func typeSelected(_ sender: Any) {
        segmentedControl.selectedSegmentIndex == 0 ? createButton.setTitle("Create Project", for: .normal) : createButton.setTitle("Create Task", for: .normal)
}
    

    
}
