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
    
    func addGradient(topColor: UIColor, bottomColor: UIColor) {
        let gradient = CAGradientLayer()
        gradient.frame = contentView.bounds
        gradient.colors = [topColor.cgColor, bottomColor.cgColor]
        gradient.locations = [0.0, 1.0]
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 0, y: 1)
        contentView.layer.insertSublayer(gradient, at: 0)
    }
}


