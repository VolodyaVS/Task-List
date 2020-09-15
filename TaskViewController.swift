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
    
    var tasks: [Task]!
    var user: User!
    
    // MARK: - Private properties
    
    private var isAscending = true
    
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
        tabBarController?.navigationItem.leftBarButtonItems = [sortButton]
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
        
        if task.done {
            cell.doneButton.setImage(UIImage(systemName: "checkmark"), for: .normal)
        } else {
            cell.doneButton.setImage(UIImage(systemName: "exclamationmark"), for: .normal)
        }
        
        var isDone = tasks[indexPath.row].done
        
        cell.doneColsure = {
            isDone.toggle()
            self.tasks[indexPath.row].done = isDone
            tableView.reloadData()
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    @objc func inversedSorting() {
        isAscending.toggle()
        if isAscending {
            tabBarController?.navigationItem.leftBarButtonItem?.image
                = UIImage(systemName: "arrow.down")
        } else {
            tabBarController?.navigationItem.leftBarButtonItem?.image
                = UIImage(systemName: "arrow.up")
        }
        sorting()
    }
    
    // Sorting task by name
    private func sorting() {
        if isAscending {
            tasks = tasks.sorted { $0.task < $1.task }
            tableView.reloadData()
        } else {
            tasks = tasks.sorted { $0.task > $1.task }
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
            tableView.insertRows(at: [newIndexPath], with: .fade)
        }
    }
    
    // MARK: - Swipe Actions
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tasks.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let favourite = favouriteAction(at: indexPath)
        return UISwipeActionsConfiguration(actions: [favourite])
    }
    
    func favouriteAction(at indexPath: IndexPath) -> UIContextualAction {
        var task = tasks[indexPath.row]
        let action = UIContextualAction(style: .normal, title: "Favourite") {
            _, _, completion in
            task.isFavorite = !task.isFavorite
            self.tasks[indexPath.row] = task
            completion(true)
        }
        action.backgroundColor = task.isFavorite ? .systemPurple : .systemGray
        action.image = UIImage(systemName: "heart")
        return action
    }
}
