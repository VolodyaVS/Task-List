//
//  Task.swift
//  Task List
//
//  Created by Denis Svetlakov on 12.09.2020.
//  Copyright © 2020 Vladimir Stepanchikov. All rights reserved.
//

import Foundation
import UIKit

struct Task {
    
    var task: String
    var dueDate: String
    var done: Bool
    var isFavorite: Bool
    var user: User?
}

extension Task {
    
    static func getTaskList(user: User?) -> [Task] {
        let tasksList: [Task] = DataManager.shared.tasks
        return tasksList
    }
    
    static func addTask(user: User, task: String, duedate: String, done: Bool, isFavorite: Bool) {
        let task = Task(task: task, dueDate: duedate, done: done, isFavorite: isFavorite, user: user)
        DataManager.shared.tasks.append(task)
    }
}
