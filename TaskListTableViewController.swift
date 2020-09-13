//
//  TaskListViewController.swift
//  Task List
//
//  Created by Denis Svetlakov on 12.09.2020.
//  Copyright © 2020 Vladimir Stepanchikov. All rights reserved.
//

import UIKit

class TaskViewController: UITableViewController {

    var tasks = Task.getTaskList()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "task", for: indexPath)
        let task = tasks[indexPath.row]
        cell.textLabel?.text = task.task
        cell.detailTextLabel?.text = task.dueDate
        if task.done {
            cell.imageView?.image = UIImage(systemName: "checkmark")
        } else  { cell.imageView?.image = UIImage(systemName: "tray") }
        return cell
    }
    
   override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
          tableView.deselectRow(at: indexPath, animated: true)
      }

}
