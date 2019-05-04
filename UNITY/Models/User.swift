//
//  User.swift
//  UNITY
//
//  Created by Caleb Maccarone on 5/3/19.
//  Copyright © 2019 Caleb Maccarone. All rights reserved.
//

import Foundation

struct User: Hashable,Equatable {
    var name:String?
    var email:String?
    var userType:UserType?
    var userID = UUID.init()
}

