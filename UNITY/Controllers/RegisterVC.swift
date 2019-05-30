//
//  RegisterVC.swift
//  UNITY
//
//  Created by Caleb Maccarone on 4/27/19.
//  Copyright © 2019 Caleb Maccarone. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class RegisterVC: UIViewController, UITextFieldDelegate {
    //IB outlets Here
    
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var emailField: RoundedTextField!
    @IBOutlet weak var passwordField: RoundedTextField!
    @IBOutlet weak var passwordVerifyField: RoundedTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboard()
        emailField.delegate = self
        passwordField.delegate = self
        passwordVerifyField.delegate = self
        
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    

    
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
                    self.errorLabel.text = Error?.localizedDescription
                        self.errorLabel.isHidden = false
                    print(Error.debugDescription)
                    print(Error!.localizedDescription)
                    return
             
                }
                
                if AuthResult?.user.uid != nil {
                    DispatchQueue.global(qos: .userInteractive).async {
                        //TODO: add instance of user to the Firestore database. This list will hold the username/ID in which I will store info like their friend's list, friend requests, messaging ect.
                        DispatchQueue.main.async {
                            //Main UI Thread
                            self.performSegue(withIdentifier: "presentProjectsVC", sender: self)
                            return
                        }
                    }
                    
                } else {
                    self.errorLabel.text = "ERROR"
                }
            }
        }
}
    // controls return button UX behavior on keyboard.
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == passwordVerifyField {
            textField.resignFirstResponder()
            registerButtonPressed(self)
            return true
        } else if textField == emailField {
                passwordField.select(self)
            return true
        } else if textField == passwordField {
                passwordVerifyField.select(self)
            return true
        }
        return true
        }
        
    }
    




