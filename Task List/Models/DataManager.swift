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

    private init() {}

    // add User
    var users: [String: User] = ["1": User(name: "1", password: "1")]

    var tasks: [Task] = [
        Task(task: "Create task VC", dueDate: "02/10/2020",
             done: true, isFavorite: true, user: nil),
        Task(task: "Buy milk", dueDate: "15/09/2020",
             done: false, isFavorite: true, user: nil),
        Task(task: "Find solution", dueDate: "30/09/2020",
             done: true, isFavorite: true, user: nil)
    ]
}
