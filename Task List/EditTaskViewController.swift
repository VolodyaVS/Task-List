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
    var newTask = Task(task: "",
                       dueDate: "",
                       done: false,
                       isFavorite: false,
                       user: nil)
    
    // MARK: - Override methods
    override func viewDidLoad() {
        super.viewDidLoad()
        datePickerTaskOutlet.datePickerMode = .date
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "dd/MM/yyyy"
        let newTaskDate = dateFormater.string(from: datePickerTaskOutlet.date)
       
        if segue.identifier == "saveNewTask" {
            newTask.task = taskTFOutlet.text ?? "default"
            newTask.dueDate = newTaskDate
            newTask.user = user
            newTask.isFavorite = isFavoriteSwitchOutlet.isOn
        }
    }
    
}
