//
//  RegistrationViewController.swift
//  Task List
//
//  Created by Yaroslav on 13.09.2020.
//  Copyright © 2020 Vladimir Stepanchikov. All rights reserved.
//

import UIKit

class RegistrationViewController: UIViewController {

    @IBOutlet var newUserNameRegistration: UITextField!
    @IBOutlet var newPasswordRegistration: UITextField!
    
    
    @IBAction func cancelButtonPressed() {
        dismiss(animated: true)
    }
}

// MARK: Text Field Delegate
extension RegistrationViewController: UITextFieldDelegate {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
}

