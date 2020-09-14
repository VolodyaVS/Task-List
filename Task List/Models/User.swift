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
        
//        var users: [User] = []
//        for (key, value) in DataManager.shared.users {
//            users.append(User(name: key, password: value))
//        }
        
        return [User(name: "1", password: "1")]
    }
    
    static func addNewUser(name: String, password: String) {
        
//        DataManager.shared.users[name] = password
        
    }
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
