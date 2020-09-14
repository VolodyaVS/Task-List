//
//  FavoritesTasksTableViewController.swift
//  Task List
//
//  Created by Кирилл Файфер on 13.09.2020.
//  Copyright © 2020 Vladimir Stepanchikov. All rights reserved.
//

import UIKit

class FavoritesTasksTableViewController: UITableViewController {
    var tasks = Task.getTaskList()
    
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var counter = 0
        
        for task in self.tasks {
            if task.isFavorite {
                counter += 1
            }
        }
        return counter
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favoritesTasks", for: indexPath)
        
        if self.tasks[indexPath.row].isFavorite {
            cell.textLabel?.text = self.tasks[indexPath.row].task
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = deleteAction(at: indexPath)
        
        return UISwipeActionsConfiguration(actions: [delete])
    }
    
    func deleteAction(at indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .normal, title: "Delete") { (action, view, complition) in
            var index = indexPath.row
            
            for favorite in 0...indexPath.row {
                if !self.tasks[favorite].isFavorite {
                    index += 1
                }
            }
            self.tasks[index].isFavorite = !self.tasks[index].isFavorite
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            
            complition(true)
        }
        action.backgroundColor = .red
        
        return action
    }
}
