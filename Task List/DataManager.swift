//
//  DataManager.swift
//  Task List
//
//  Created by Denis Svetlakov on 12.09.2020.
//  Copyright © 2020 Vladimir Stepanchikov. All rights reserved.
//

import Foundation

class DataManager {
    
    static let shared = DataManager()
    
    private init () {}
    
    let tasks = ["To create task VC", "To buy milk", "To find solution"]
    let dueDates = ["02/10/2020", "15/09/2020", "30/09/2020"]
    let dones = [false, true, false]
    
}
