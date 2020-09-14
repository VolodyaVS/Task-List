//
//  EditTaskViewController.swift
//   List
//
//  Created by Aquesta 's on 13.09.2020.
//  Copyright © 2020 Vladimir Stepanchikov. All rights reserved.
//

import UIKit

class EditTaskViewController: UIViewController {
    
    // MARK: - IB Outlets
    @IBOutlet var taskTFOutlet: UITextField!
    @IBOutlet var isFavoriteSwitchOutlet: UISwitch!
    @IBOutlet var datePickerTaskOutlet: UIDatePicker!
    @IBOutlet var saveButtonOutlet: UIBarButtonItem!
    
    // MARK: - Public properties
    var user: User!
    var task = Task(task: "",
                       dueDate: "22/11/2020",
                       done: false,
                       isFavorite: false,
                       user: nil)
    var indexPath: IndexPath!
    
    
    // MARK: - Override methods
    override func viewDidLoad() {
        super.viewDidLoad()
        datePickerTaskOutlet.datePickerMode = .date
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "dd/MM/yyyy"
        
        taskTFOutlet.text = task.task
        isFavoriteSwitchOutlet.isOn = task.isFavorite
        datePickerTaskOutlet.date = dateFormater.date(from: task.dueDate)!
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "dd/MM/yyyy"
        let newTaskDate = dateFormater.string(from: datePickerTaskOutlet.date)
       
        if segue.identifier == "saveTask" {
            task.task = taskTFOutlet.text ?? "default"
            task.dueDate = newTaskDate
            task.user = user
            task.isFavorite = isFavoriteSwitchOutlet.isOn
        }
    }
    
}
