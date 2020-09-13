//
//  TabBarViewController.swift
//  Task List
//
//  Created by Denis Svetlakov on 13.09.2020.
//  Copyright © 2020 Vladimir Stepanchikov. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {

    var tasks = Task.getTaskList()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewControllers(with: tasks)
    }
    
    private func setupViewControllers(with task: [Task]) {
        let tasksListVC = viewControllers?.first as! TaskViewController
//        let favoriteVC = viewControllers?.last as!
        
        tasksListVC.tasks = tasks
//        favoriteVC.tasks = tasks
    }
}
