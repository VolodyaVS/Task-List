//
//  EditTaskViewController.swift
//   List
//
//  Created by Aquesta 's on 13.09.2020.
//  Copyright © 2020 Vladimir Stepanchikov. All rights reserved.
//

import UIKit

class EditTaskViewController: UIViewController {
    @IBOutlet var taskTFOutlet: UITextField!
    @IBOutlet var isFavoriteSwitchOutlet: UISwitch!
    @IBOutlet var datePickerTaskOutlet: UIDatePicker!
    @IBOutlet var saveButtonOutlet: UIBarButtonItem!
    
    var user: User!
    private var newTaskDate = ""
    var newTask = Task(task: "", dueDate: "", done: false, priority: 1, isFavorite: false, user: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        datePickerTaskOutlet.datePickerMode = .date
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "saveNewTask" {
            newTask.task = taskTFOutlet.text ?? "default"
            newTask.dueDate = newTaskDate
            newTask.user = user
            newTask.isFavorite = isFavoriteSwitchOutlet.isOn
        }
    }
    
    private func datePickerChangeValue(_ sender: UIDatePicker) {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "yyyy-MM-dd"
        newTaskDate = dateFormater.string(from: datePickerTaskOutlet.date)
    }
}
