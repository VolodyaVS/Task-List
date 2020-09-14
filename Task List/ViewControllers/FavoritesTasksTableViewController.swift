//
//  FavoritesTasksTableViewController.swift
//  Task List
//
//  Created by Кирилл Файфер on 14.09.2020.
//  Copyright © 2020 Vladimir Stepanchikov. All rights reserved.
//

import UIKit

class FavoritesTasksTableViewController: UITableViewController {
    
    // MARK: - Public Properties
    var tasks = Task.getTaskList(user: nil)
    
    // MARK: - Override methods
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.navigationItem.leftBarButtonItem = nil
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var counter = 0
        
        for task in tasks {
            if task.isFavorite {
                counter += 1
            }
        }
        return counter
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favoritesTasks", for: indexPath)
        
        if tasks[indexPath.row].isFavorite {
            cell.textLabel?.text = tasks[indexPath.row].task
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: - Swipe Actions
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = deleteAction(at: indexPath)

        return UISwipeActionsConfiguration(actions: [delete])
    }

    func deleteAction(at indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .destructive, title: "Delete") { (action, view, complition) in
            var index = indexPath.row

            for favorite in 0...indexPath.row {
                if !self.tasks[favorite].isFavorite {
                    index += 1
                }
            }
            self.tasks[index].isFavorite.toggle()
            self.tableView.deleteRows(at: [indexPath], with: .fade)
            
            complition(true)
        }
        action.backgroundColor = .red

        return action
    }
    
}
