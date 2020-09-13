//
//  User.swift
//  Task List
//
//  Created by Aquesta 's on 12.09.2020.
//  Copyright © 2020 Vladimir Stepanchikov. All rights reserved.
//

struct User {
    
    var name: String
    var password: String
    
    static func getUserData() -> [User] {
        
        var users: [User] = []
        for (key, value) in DataManager.shared.users {
            users.append(User(name: key, password: value))
        }
        
        return users
    }
    
    static func addNewUser(name: String, password: String) {
        DataManager.shared.users[name] = password
    }
}
