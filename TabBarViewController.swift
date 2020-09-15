//
//  TabBarViewController.swift
//  Task List
//
//  Created by Denis Svetlakov on 13.09.2020.
//  Copyright © 2020 Vladimir Stepanchikov. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {
    // MARK: - Public Properties

    var user: User!
    
    // MARK: - Override methods

    override func viewDidLoad() {
        super.viewDidLoad()
        let tasks = Task.getTaskList(user: user)
        setupViewControllers(tasks: tasks)
    }
    
    // MARK: - Private methods

    private func setupViewControllers(tasks: [Task]) {
        let tasksListVC = viewControllers?.first as! TaskViewController
        let favoriteListVC = viewControllers?.last as! FavoritesTasksTableViewController
        tasksListVC.user = user
        tasksListVC.tasks = tasks
        tasksListVC.title = "Task \(user.name)"
        
        favoriteListVC.user = user
        favoriteListVC.tasks = tasks
        favoriteListVC.title = "Favorite Task \(user.name)"
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addTask" {
            let addTaskVC = segue.destination as! EditTaskViewController
            addTaskVC.user = user
            addTaskVC.title = "New Task"
        }
    }
}
