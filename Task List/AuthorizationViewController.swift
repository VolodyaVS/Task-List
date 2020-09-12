//
//  AuthorizationViewController.swift
//  Task List
//
//  Created by Aquesta 's on 12.09.2020.
//  Copyright © 2020 Vladimir Stepanchikov. All rights reserved.
//

import UIKit

class AuthorizationViewController: UIViewController {
    
    @IBOutlet weak var userNameTFOutlet: UITextField!
    @IBOutlet weak var passwordTFOutlet: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func loginButtonAction() {
        guard let userName = userNameTFOutlet.text, !userName.isEmpty else {
            showAlert(title: "Username is empty", message: "Please enter username")
            return
        }
        
        guard let password = passwordTFOutlet.text, !password.isEmpty else {
                   showAlert(title: "Password is empty", message: "Please enter password")
                   return
               }
        
        guard let user = User.authorizationCheck(username: userName, password: password) else {
            showAlert(title: "User not found", message: "Please try again or register")
            return
        }
        
        performSegue(withIdentifier: "logIn", sender: user)
    }
}

// MARK: - Alert Controller
extension AuthorizationViewController {
    private func showAlert(title: String, message: String, textField: UITextField? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            textField?.text = nil
        }
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}

// MARK: Text Field Delegate
extension AuthorizationViewController: UITextFieldDelegate {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == userNameTFOutlet {
            textField.resignFirstResponder()
            passwordTFOutlet.becomeFirstResponder()
        } else {
            //logInPressed()
        }
        return true
    }
}

