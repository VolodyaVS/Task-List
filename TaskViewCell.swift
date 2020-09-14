//
//  TaskViewCell.swift
//  Task List
//
//  Created by Denis Svetlakov on 13.09.2020.
//  Copyright © 2020 Vladimir Stepanchikov. All rights reserved.
//

import UIKit

class TaskViewCell: UITableViewCell {
    
    var doneColsure : (() -> Void)? = nil
    
    @IBOutlet weak var taskDescriptionLabel: UILabel!
    @IBOutlet weak var dueDataLabel: UILabel!
    @IBOutlet weak var doneButton: UIButton!
    
    @IBAction func doneButtonPressed(_ sender: Any) {
        if let doneButtonAction = self.doneColsure {
            doneButtonAction()
        }
    }
}
