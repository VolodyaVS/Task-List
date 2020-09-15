//
//  TaskViewCell.swift
//  Task List
//
//  Created by Denis Svetlakov on 13.09.2020.
//  Copyright © 2020 Vladimir Stepanchikov. All rights reserved.
//

import UIKit

class TaskViewCell: UITableViewCell {
    
    // MARK: - IB Outlets
    @IBOutlet weak var taskDescriptionLabel: UILabel!
    @IBOutlet weak var dueDataLabel: UILabel!
    @IBOutlet weak var doneButton: UIButton!
    
    // MARK: - Properties
    var doneColsure : (() -> Void)? = nil
    
    
    // MARK: - IB Actions
    @IBAction func doneButtonPressed(_ sender: Any) {
        if let doneButtonAction = self.doneColsure {
            doneButtonAction()
        }
    }
    
}
