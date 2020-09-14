//
//  RegistrationViewController.swift
//  Task List
//
//  Created by Yaroslav on 13.09.2020.
//  Copyright © 2020 Vladimir Stepanchikov. All rights reserved.
//

import UIKit

class RegistrationViewController: UIViewController {
    
    // MARK: - IB Outlets
    @IBOutlet var newUserNameRegistration: UITextField!
    @IBOutlet var newPasswordRegistration: UITextField!
    
    // MARK: - Override methods
    override func viewDidLoad() {
        newUserNameRegistration.delegate = self
        newPasswordRegistration.delegate = self
    }
    
    //MARK: – IB Actions
    @IBAction func registerButtonTapped() {
        guard let username = newUserNameRegistration.text, !username.isEmpty
            else { showAlert(title:"Oooooops!😱",
                             message: "Your username field is empty")
            return
        }
        guard let password = newPasswordRegistration.text, !password.isEmpty
            else { showAlert(title:"Oooooops!😱",
                             message: "Your passworld field is empty")
            return
        }
        performSegue(withIdentifier: "registrationSegue", sender: self)
    }
    
    @IBAction func cancelButtonPressed() {
        dismiss(animated: true)
    }
}

// MARK: - Alert Controller
extension RegistrationViewController {
    
    private func showAlert(title: String, message: String, textField: UITextField? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            textField?.text = nil
        }
        
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
}

// MARK: - Text Field Delegate
extension RegistrationViewController: UITextFieldDelegate {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == newUserNameRegistration {
            textField.resignFirstResponder()
            newPasswordRegistration.becomeFirstResponder()
        } else {
            registerButtonTapped()
        }
        return true
    }
    
}

