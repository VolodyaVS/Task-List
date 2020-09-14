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
    
    // MARK: - Override methods
    override func viewWillAppear(_ animated: Bool) {
                let sortButton = UIBarButtonItem(image: UIImage(systemName: "arrow.down"),
                                         style: .plain, target: self,
                                         action: #selector(inversedSorting))
        
        self.tabBarController?.navigationItem.leftBarButtonItems = [sortButton]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        sorting()
//        let sortButton = UIBarButtonItem(image: UIImage(systemName: "arrow.down"),
//                                         style: .plain, target: self,
//                                         action: #selector(inversedSorting))
//
//        self.tabBarController?.navigationItem.leftBarButtonItems = [sortButton]
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
            cell.doneButton.setImage(UIImage(systemName: "checkmark"), for: .normal)
        } else  {
            cell.doneButton.setImage(UIImage(systemName: "exclamationmark"), for: .normal)
        }
        
        var isDone = tasks[indexPath.row].done
        
        cell.doneColsure  = {
            isDone.toggle()
            self.tasks[indexPath.row].done = isDone
            tableView.reloadData()
            print (self.tasks)
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: - Swipe Actions
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let favorite = favoriteAction(at: indexPath)

        return UISwipeActionsConfiguration(actions: [favorite])
    }
    
    func favoriteAction(at indexPath: IndexPath) -> UIContextualAction {
        let actionTitle: String = tasks[indexPath.row].isFavorite ? "Unfavorite" : "Favorite"
        
        let action = UIContextualAction(style: .destructive, title: actionTitle) { (action, view, complition) in
            var task = self.tasks[indexPath.row]
    
            task.isFavorite.toggle()
            self.tasks[indexPath.row] = task
            
            complition(true)
        }
        action.backgroundColor = UIColor(red: 17/255, green: 154/255, blue: 237/255, alpha: 1)

        return action
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
            tasks = tasks.sorted() { $0.task > $1.task }
            tableView.reloadData()
        } else {
            tasks = tasks.sorted() { $0.task < $1.task }
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
