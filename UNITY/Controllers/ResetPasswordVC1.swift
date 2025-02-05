//
//  ResetPasswordVC1.swift
//  UNITY
//
//  Created by Caleb Maccarone on 4/28/19.
//  Copyright © 2019 Caleb Maccarone. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class ResetPasswordVC1: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var emailField: RoundedTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboard()
        self.emailField.delegate = self
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
        startAnimating(size: .small)
        Auth.auth().sendPasswordReset(withEmail: email) { (error) in
            if let error = error {
                self.stopAnimating()
                self.errorLabel.text = error.localizedDescription
                self.errorLabel.isHidden = false
                return
            } else {
            self.stopAnimating()
            self.dismiss(animated: true, completion: nil)
            
            }
        }
    }
    }
   
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        resetPassword(self)
        return true
    }

    
}
