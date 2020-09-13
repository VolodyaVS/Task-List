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
    
    let task: String
    let dueDate: String
    let done: Bool
    let priority: Int
}

extension Task {
    
    static func getTaskList() -> [Task] {
        
        var tasksList: [Task] = []
        
        let tasks = DataManager.shared.tasks
        let dueDates = DataManager.shared.dueDates
        let dones = DataManager.shared.dones
        let prioritys = DataManager.shared.priority
        
        for index in 0..<tasks.count {
            let tasks = Task(task: tasks[index],
                             dueDate: dueDates[index],
                             done: dones[index], priority: prioritys[index])
            tasksList.append(tasks)
        }
        return tasksList
    }
    //
    //    func dataFormatter (dateString: String) -> Date {
    //        let dateFormatter = DateFormatter()
    //        dateFormatter.dateFormat = "dd/MM/yyyy"
    //        return dateFormatter.date(from: dateString) ?? Date()
    //    }
    
}
