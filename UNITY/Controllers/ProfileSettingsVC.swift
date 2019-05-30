//
//  ProfileSettingsVC.swift
//  UNITY
//
//  Created by Caleb Maccarone on 5/30/19.
//  Copyright © 2019 Caleb Maccarone. All rights reserved.
//

import UIKit
import Firebase


class ProfileSettingsVC: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profilePicture: RoundedProfileButton!
    @IBOutlet weak var topView: UIView!
    var profilePictureToUpload = UIImage()
    let profilePictureRef = Storage.storage().reference().child("new/\(Auth.auth().currentUser!.uid)")
    
    
    @IBAction func signOutPressed(_ sender: Any) {
        do {
            try Auth.auth().signOut()
        } catch {
            print(error)
        }
    }
    
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    //This Action presents an alert that lest the user choose how they will choose thier profile picture photo.
    @IBAction func changeProfilePicture(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self
        let choosePictureSourcePopup = UIAlertController()
        let cameraAction = UIAlertAction(title: "Take Picture", style: .default) { (takePic) in
            picker.sourceType = .camera
            self.present(picker,animated: true)
            picker.showsCameraControls = true
        }
        let photoLibraryAction = UIAlertAction(title: "Choose Photo", style: .default) { (choosePhoto) in
            picker.sourceType = .photoLibrary
            self.present(picker,animated: true)
        }
        choosePictureSourcePopup.addAction(cameraAction)
        choosePictureSourcePopup.addAction(photoLibraryAction)
        choosePictureSourcePopup.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        picker.allowsEditing = true
        
        self.present(choosePictureSourcePopup, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.editedImage] as? UIImage {
            //TODO: add image to firebase
            profilePictureToUpload = image
            profilePicture.setBackgroundImage(image, for: .normal)
            var data = Data()
            data = Data()
            data = image.jpegData(compressionQuality: 0.30)!
         
            let storageRef = Storage.storage().reference()
            let uid = Auth.auth().currentUser!.uid
            storageRef.child("new/\(uid)").putData(data, metadata: nil) { (nil, error) in
                if let error = error {
                    print(error)
                }
            }
            
            
            
        }
        dismiss(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        profilePicture.layer.borderWidth = 3
        topView.layer.borderColor = #colorLiteral(red: 0.5921568627, green: 0.5921568627, blue: 0.5921568627, alpha: 1)
        topView.layer.borderWidth = 1
        
        //loads profile picture
        profilePictureRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
            if let error = error {
                print(error)
            } else {
                // Data for "images/island.jpg" is returned
                let image = UIImage(data: data!)
                self.profilePicture.setImage(image, for: .normal)
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        profilePicture.subviews.first?.contentMode = .scaleAspectFill
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
