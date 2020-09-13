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
    private var isAscending = true
    
//    private var sortButton = UIBarButtonItem(image: UIImage(systemName: "arrow.down"),
//    style: .plain, target: self,
//    action: #selector(inversedSorting))

    override func viewDidLoad() {
        super.viewDidLoad()
    
        sorting()
        let sortButton = UIBarButtonItem(image: UIImage(systemName: "arrow.down"),
        style: .plain, target: self,
        action: #selector(inversedSorting))

        self.tabBarController?.navigationItem.leftBarButtonItems = [sortButton]
        
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "task", for: indexPath) as! TaskViewCell
        let task = tasks[indexPath.row]
        cell.taskDescriptionLabel.text = task.task
        cell.dueDataLabel.text = task.dueDate
        if task.done {
            cell.doneImageView.image = UIImage(systemName: "checkmark")
        } else  { cell.doneImageView.image = UIImage(systemName: "exclamationmark") }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    @objc func inversedSorting() {
        isAscending.toggle()
        if isAscending {
            self.tabBarController?.navigationItem.leftBarButtonItem?.image
                = UIImage(systemName: "arrow.down")
        } else {
              self.tabBarController?.navigationItem.leftBarButtonItem?.image
                = UIImage(systemName: "arrow.up")
        }
        sorting()
    }
    
    //Sorting task by name 
    @objc func sorting(){
        if isAscending {
            tasks = tasks.sorted() { $0.task > $1.task }
            tableView.reloadData()
        } else {
            tasks = tasks.sorted() { $0.task < $1.task }
            tableView.reloadData()
        }
    }
}
