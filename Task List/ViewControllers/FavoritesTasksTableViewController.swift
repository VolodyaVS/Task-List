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
    
    var tasks: [Task]!
    var user: User!
    
    // MARK: - Override methods
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.navigationItem.leftBarButtonItem = nil
        tableView.reloadData()
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
