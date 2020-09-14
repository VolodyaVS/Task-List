//
//  TaskListViewController.swift
//  Task List
//
//  Created by Denis Svetlakov on 12.09.2020.
//  Copyright © 2020 Vladimir Stepanchikov. All rights reserved.
//

import UIKit

class TaskViewController: UITableViewController {
    
    // MARK: - Public Properties
    var tasks = Task.getTaskList(user: nil)
    var user: User!
    
    // MARK: - Private properties
    private var isAscending = true
    
    private let primaryColor = UIColor(
        red: 80/255,
        green: 82/255,
        blue: 100/255,
        alpha: 1
    )
    private let secondaryColor = UIColor(
        red: 190/255,
        green: 190/255,
        blue: 190/255,
        alpha: 1
    )
    
    // MARK: - Override methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sorting()
        
        tableView.layoutMargins = UIEdgeInsets.zero
        tableView.separatorInset = UIEdgeInsets.zero
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
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
        cell.layoutMargins = UIEdgeInsets.zero
        cell.contentView.backgroundColor = UIColor.clear
        
        if task.done {
            cell.doneButton.setImage(UIImage(systemName: "checkmark"), for: .normal)
        } else  {
            cell.doneButton.setImage(UIImage(systemName: "exclamationmark"), for: .normal)
        }
        
        var isDone = tasks[indexPath.row].done
        
        cell.doneColsure  = {
            isDone.toggle()
            self.tasks[indexPath.row].done = isDone
            tableView.reloadData()
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if cell is TaskViewCell {
            (cell as! TaskViewCell).addGradient(topColor: primaryColor, bottomColor: secondaryColor)
        }
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
    private func sorting(){
        if isAscending {
            tasks = tasks.sorted() { $0.task < $1.task }
            tableView.reloadData()
        } else {
            tasks = tasks.sorted() { $0.task > $1.task }
            tableView.reloadData()
        }
    }
    
    
    // send user to EditTaskViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editTask" {
            let indexPath = tableView.indexPathForSelectedRow!
            let task = tasks[indexPath.row]
            let editTaskVC = segue.destination as! EditTaskViewController
            editTaskVC.task = task
            editTaskVC.title = "Edit Task"
            editTaskVC.indexPath = indexPath
        }
    }
    
    // get new task from EditTaskViewController
    @IBAction func unwind(_ segue: UIStoryboardSegue) {
        guard segue.identifier == "saveTask" else { return }
        let sourceVC = segue.source as! EditTaskViewController
        let task = sourceVC.task
        let indexPath = sourceVC.indexPath
        
        if let selectedIndexPath = indexPath {
            tasks[selectedIndexPath.row] = task
            tableView.reloadRows(at: [selectedIndexPath], with: .fade)
        } else {
            let newIndexPath = IndexPath(row: tasks.count, section: 0)
            tasks.append(task)
            tableView.insertRows(at: [newIndexPath], with: .fade  )
        }
    }
}

