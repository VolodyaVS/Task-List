//
//  User.swift
//  Task List
//
//  Created by Aquesta 's on 12.09.2020.
//  Copyright © 2020 Vladimir Stepanchikov. All rights reserved.
//

struct User {
    var name: String
    var mail: String
    var password: String
}

// init function
extension User {
    
    static func authorizationCheck(username: String, password: String) -> User? {
        
        let users = DataManager.shared.users
     
        if let user = users[username] {
            if user.password == password {
                return user
            }
        }
        return nil
    }
}

