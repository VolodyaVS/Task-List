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
    
    // MARK: - Private properties
    private let primaryColor = UIColor(
        red: 230/255,
        green: 250/255,
        blue: 250/255,
        alpha: 1
    )
    private let secondaryColor = UIColor(
        red: 87/255,
        green: 152/255,
        blue: 255/255,
        alpha: 1
    )
    
    // MARK: - Override methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addVerticalGradientLayer(topColor: primaryColor, bottomColor: secondaryColor)
        
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

extension EditTaskViewController {
    func addVerticalGradientLayer(topColor: UIColor, bottomColor: UIColor) {
        let gradient = CAGradientLayer()
        gradient.frame = view.bounds
        gradient.colors = [topColor.cgColor, bottomColor.cgColor]
        gradient.locations = [0.0, 1.0]
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 0, y: 1)
        view.layer.insertSublayer(gradient, at: 0)
    }
}
