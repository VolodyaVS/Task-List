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
        setupViewControllers(with: tasks)
    }
    
    // MARK: - Private methods
    private func setupViewControllers(with task: [Task]) {
        
        let tasksListVC = viewControllers?.first as! TaskViewController
        
        //        let favoriteVC = viewControllers?.last as!
        
        //        tasksListVC.tasks = task
        tasksListVC.user = user
        //        favoriteVC.tasks = tasks
    }
    
}
