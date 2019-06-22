//
//  ViewController.swift
//  UNITY
//
//  Created by Caleb Maccarone on 4/26/19.
//  Copyright © 2019 Caleb Maccarone. All rights reserved.
//

enum UserDefaultKeys: String {
    case UID = "UID"
}

import UIKit
import Firebase
import FirebaseAuth

class SignInVC: UIViewController, UITextFieldDelegate  {
    //vars
    let user = User()
    let user1 = User()
    
    
    var placeHolder: String?
    //outlets/Actions
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var emailTextField: RoundedTextField!
    
    @IBOutlet weak var passwordTextField: RoundedTextField!
    
    @IBAction func signInWithTouchID(_ sender: Any) {
    }
    
    
    
    @IBAction func signInRegular(_ sender: Any) {
        if emailTextField.text != "", passwordTextField.text != "" {
            startAnimating(size: .small)
            Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { (result, error) in
                
            if let error = error {
                self.stopAnimating()
                self.errorLabel.isHidden = false
                self.errorLabel.text = error.localizedDescription
            return
            }
            if result?.user.uid != nil {
                    let profilePictureRef = Storage.storage().reference().child("new/\(Auth.auth().currentUser!.uid)")
                    profilePictureRef.getData(maxSize: 1 * 1024 * 1024) { photo, error in
                        if let error = error {
                            print(error)
                            self.saveImage(image: #imageLiteral(resourceName: "ProfilePhoto"), named: User.profilePicture)
                            self.stopAnimating()
                            self.performSegue(withIdentifier: "showProjectsVC", sender: self)
                        } else {
                            
                                //Main UI Thread
                                // Data for "images/island.jpg" is returned
                                let image = UIImage(data: photo!)
                                self.saveImage(image: image ?? #imageLiteral(resourceName: "ProfilePhoto"), named: User.profilePicture)
                                self.stopAnimating()
                                self.performSegue(withIdentifier: "showProjectsVC", sender: self)
                            
                            
                        }
                    }
                    
                
                
                
                
            }
        }
    }
    }
    
 
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboard()
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
    }
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        errorLabel.isHidden = true
    }
    

    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextField {
            passwordTextField.select(self)
            return true
        } else {
            textField.resignFirstResponder()
            signInRegular(self)
            return true
        }
    }
    
  
    
}

