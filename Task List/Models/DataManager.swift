//
//  DataManager.swift
//  Task List
//
//  Created by Denis Svetlakov on 12.09.2020.
//  Copyright © 2020 Vladimir Stepanchikov. All rights reserved.
//

import Foundation

class DataManager {
    
    static let shared = DataManager()
    
    private init () {}
    
//    let task = ["To create task VC", "To buy milk", "To find solution"]
//    let dueDates = ["02/10/2020", "15/09/2020", "30/09/2020"]
//    let dones = [false, true, false]
//    let priority = [1, 2, 3, 2]
    
//    var users: [String: String] = ["User": "Password", "Alexey": "Efimov"]
  
    // add User  
    var users: Dictionary<String, User> = ["1": User(name: "1", password: "1")]
   
    var tasks: [Task] = [
                    Task(task: "To create task VC", dueDate: "02/10/2020",
                    done: true, isFavorite: false, user: nil),
                    Task(task: "To buy milk", dueDate: "15/09/2020",
                    done: false, isFavorite: false, user: nil),
                    Task(task: "To find solution", dueDate: "30/09/2020",
                    done: true, isFavorite: true, user: nil)
    ]

}
