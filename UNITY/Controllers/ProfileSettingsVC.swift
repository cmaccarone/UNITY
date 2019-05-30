//
//  ProfileSettingsVC.swift
//  UNITY
//
//  Created by Caleb Maccarone on 5/30/19.
//  Copyright © 2019 Caleb Maccarone. All rights reserved.
//

import UIKit

class ProfileSettingsVC: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profilePicture: RoundedProfileButton!
    
    @IBOutlet weak var topView: UIView!
    @IBAction func signOutPressed(_ sender: Any) {
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func changeProfilePicture(_ sender: Any) {
        let image = UIImagePickerController()
        image.delegate = self
        image.sourceType = .camera
        image.allowsEditing = true
        self.present(image,animated: true){
            //do something
        }
        
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            ProjectVC.proPicture = image
            profilePicture.setBackgroundImage(image, for: .normal)
            
        }
        dismiss(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        profilePicture.layer.borderWidth = 3
        topView.layer.borderColor = #colorLiteral(red: 0.5921568627, green: 0.5921568627, blue: 0.5921568627, alpha: 1)
        topView.layer.borderWidth = 1
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
