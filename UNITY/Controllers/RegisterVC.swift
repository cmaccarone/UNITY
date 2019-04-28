//
//  RegisterVC.swift
//  UNITY
//
//  Created by Caleb Maccarone on 4/27/19.
//  Copyright © 2019 Caleb Maccarone. All rights reserved.
//

import UIKit
import Firebase

class RegisterVC: UIViewController {
    //IB outlets Here
    
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var emailField: RoundedTextField!
    @IBOutlet weak var passwordField: RoundedTextField!
    @IBOutlet weak var passwordVerifyField: RoundedTextField!
    
    func passwordsAreSame() -> Bool {
        if passwordField.text == passwordVerifyField.text {
            errorLabel.isHidden = true
            return true
        } else {
            errorLabel.text = "Passwords Do Not Match Please Try Again."
            errorLabel.isHidden = false
            return false
        }
        
    }
    
    @IBAction func registerButtonPressed(_ sender: Any) {
        if (passwordsAreSame()), emailField.text != nil, passwordField.text != nil, passwordVerifyField != nil {
            Auth.auth().createUser(withEmail: emailField.text!, password: passwordField.text!) { (AuthResult, Error) in
                if Error != nil {
                    errorLabel.text = Error as! String
                }
            }
        }
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
        
   
}
}
