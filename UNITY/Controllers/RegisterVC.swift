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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboard()
        
        
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        presentingViewController?.dismiss(animated: true, completion: nil)
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
                    self.performSegue(withIdentifier: "presentProjectsVC", sender: self)
                    return
                } else {
                    self.errorLabel.text = "ERROR"
                }
            }
        }
        
     
    
        
   
}
}

extension UIViewController
{
    func hideKeyboard()
    {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(UIViewController.dismissKeyboard))
        
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard()
    {
        view.endEditing(true)
    }
}
