//
//  AuthorizationViewController.swift
//  Task List
//
//  Created by Aquesta 's on 12.09.2020.
//  Copyright © 2020 Vladimir Stepanchikov. All rights reserved.
//

import UIKit

class AuthorizationViewController: UIViewController {
    
    @IBOutlet var userNameTFOutlet: UITextField!
    @IBOutlet var passwordTFOutlet: UITextField!
    
    override func viewDidLoad() {
        userNameTFOutlet.delegate = self
        passwordTFOutlet.delegate = self
    }
    
    @IBAction func loginButtonAction() {
                
        guard let username = userNameTFOutlet.text, !username.isEmpty else {
            showAlert(title:"Oooooops!😱",
                      message: "Your username field is empty")
            return
        }
        guard let password = passwordTFOutlet.text, !password.isEmpty else {
            showAlert(title:"Oooooops!😱",
                      message: "Your passworld field is empty")
            return
        }
        
        for user in User.getUserData() {
            if user.name == username && user.password == password  {
                performSegue(withIdentifier: "logIn", sender: nil)
            } else { continue }
        }
        
        showAlert(title: "Oooooops!😱", message: "Your login or password is wrong")
        passwordTFOutlet.text = ""
    }
    
    @IBAction func forgotCredentialsAction() {

        var availableUsers: [String] = []
        var availablePasswords: [String] = []
        
        for user in User.getUserData() {
            availableUsers.append(user.name)
            availablePasswords.append(user.password)
        }
        
        let combinedList = Array(zip(availableUsers, availablePasswords))
        let finalList = combinedList
        .map{ "\($0), \($1)" }
        .joined(separator:"; ")

        
        showAlert(title: "Don't worry!😎",
                  message: "Available pairs of login & password are: \(finalList)")
        }
    
    @IBAction func unwindSegue(segue: UIStoryboardSegue) {
        guard let registrationVC = segue.source as? RegistrationViewController
            else { return }
        User.addNewUser(name: registrationVC.newUserNameRegistration.text!,
                        password: registrationVC.newPasswordRegistration.text!)
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

// MARK: - Text Field Delegate
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
            loginButtonAction()
        }
        return true
    }
}
