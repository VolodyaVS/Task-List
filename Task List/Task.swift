//
//  Task.swift
//  Task List
//
//  Created by Denis Svetlakov on 12.09.2020.
//  Copyright © 2020 Vladimir Stepanchikov. All rights reserved.
//

import Foundation

struct Task {
    
    let task: String
    let dueDate: Date
}

extension Task {

    static func getTaskList() -> [Task] {
        
        var tasksList: [Task] = []
        
        let tasks = DataManager.shared.tasks
        let dueDates = DataManager.shared.dueDates
        
        for index in 0..<tasks.count {
            let person = Task(task: tasks[index],
                                  dueDates: dueDates[index])
            tasksList.append(person)
        }
        return tasksList
    }
}
