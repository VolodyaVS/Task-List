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
    var priority: Int
    var isFavorite: Bool
    var user: User?
}

extension Task {
    
    static func getTaskList(user: User?) -> [Task] {
        
        let tasksList: [Task] = DataManager.shared.tasks
        
//        let tasks = DataManager.shared.task
//        let dueDates = DataManager.shared.dueDates
//        let dones = DataManager.shared.dones
//        let prioritys = DataManager.shared.priority
//
//        for index in 0..<tasks.count {
//            let tasks = Task(task: tasks[index],
//                             dueDate: dueDates[index],
//                             done: dones[index], priority: prioritys[index], isFavorite: false, user: user ?? nil)
//            tasksList.append(tasks)
//        }
        return tasksList
    }
    
    static func addTask(user: User, task: String, duedate: String, done: Bool, priority: Int, isFavorite: Bool) {
        let task = Task(task: task, dueDate: duedate, done: done, priority: priority, isFavorite: isFavorite, user: user)
        DataManager.shared.tasks.append(task)
    }
    //
    //    func dataFormatter (dateString: String) -> Date {
    //        let dateFormatter = DateFormatter()
    //        dateFormatter.dateFormat = "dd/MM/yyyy"
    //        return dateFormatter.date(from: dateString) ?? Date()
    //    }
    
}
