//
//  ResetPasswordVC1.swift
//  UNITY
//
//  Created by Caleb Maccarone on 4/28/19.
//  Copyright © 2019 Caleb Maccarone. All rights reserved.
//

import UIKit
import Firebase

class ResetPasswordVC1: UIViewController {

    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var emailField: RoundedTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dismissKeyboard()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func resetPassword(_ sender: Any) {
        if let email = emailField.text {
        Auth.auth().sendPasswordReset(withEmail: email) { (error) in
            if let error = error {
                self.errorLabel.text = error.localizedDescription
                self.errorLabel.isHidden = false
                return
            } else {
            self.dismiss(animated: true, completion: nil)
           
            }
        }
    }
    }
   
    

    
}
