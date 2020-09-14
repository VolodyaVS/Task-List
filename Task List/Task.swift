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
    let dueDate: String
    var isFavorite: Bool
}

extension Task {
    
    static func getTaskList() -> [Task] {
        
        var tasksList: [Task] = []
        
        let tasks = DataManager.shared.tasks
        let dueDates = DataManager.shared.dueDates
        
        for index in 0..<tasks.count {
            let tasks = Task(task: tasks[index],
                             dueDate: dueDates[index],
                             isFavorite: true)
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
