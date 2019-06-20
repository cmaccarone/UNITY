//
//  DataService.swift
//  UNITY
//
//  Created by Caleb Maccarone on 6/7/19.
//  Copyright © 2019 Caleb Maccarone. All rights reserved.
//

import Foundation
import Firebase



class DataService {
    
    static let shared = DataService()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    //retrives data from firebase
    func fetchData() {
        
    }
    
    //saves new data to firebase/core data
    func saveData() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("error:\(Error.self)")
            }
        }
        
    }
    
    //updates data in firebase and in core data (also recieves updates from firebase which will update coredata at the same time.)
    func updateData() {
    }
    
    // removes item from firebase and from core data
    func deleteData() {
    }
    
    //Use this function to update firebase when the device tries to save data but is unable to reach the server. saves to core data then later saves to firebase when connection is reestablished with firebase.
    func saveDataToUploadLater() {
    }
    
    init() {
    }
    
}
