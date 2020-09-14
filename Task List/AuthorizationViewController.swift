//
//  AuthorizationViewController.swift
//  Task List
//
//  Created by Aquesta 's on 12.09.2020.
//  Copyright © 2020 Vladimir Stepanchikov. All rights reserved.
//

import UIKit

class AuthorizationViewController: UIViewController {
    
    // MARK: - IB Outlets
    @IBOutlet weak var userNameTFOutlet: UITextField!
    @IBOutlet weak var passwordTFOutlet: UITextField!
    
    // MARK: - Private properties
    private let primaryColor = UIColor(
        red: 80/255,
        green: 82/255,
        blue: 100/255,
        alpha: 1
    )
    private let secondaryColor = UIColor(
        red: 190/255,
        green: 190/255,
        blue: 190/255,
        alpha: 1
    )
    
    // MARK: - Override methods
    override func viewDidLoad() {
        super.viewDidLoad()
        addVerticalGradientLayer(topColor: primaryColor, bottomColor: secondaryColor)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navBarVC = segue.destination as! UINavigationController
        let tabBarVC = navBarVC.topViewController as! TabBarViewController
        //          let tasksVC = tabBarVC.viewControllers?.first as! TaskViewController
        tabBarVC.user = sender as? User
    }
    
    //MARK – IB Actions
    @IBAction func loginButtonAction() {
        let users = User.getUserData()
        
        guard let userName = userNameTFOutlet.text, !userName.isEmpty else {
            showAlert(title:"Oooooops!😱",
                      message: "Your username field is empty")
            return
        }
        guard let password = passwordTFOutlet.text, !password.isEmpty else {
            showAlert(title:"Oooooops!😱",
                      message: "Your passworld field is empty")
            return
        }
        
        for user in users {
            if user.name == userName && user.password == password  {
                performSegue(withIdentifier: "logIn", sender: nil)
            } else { continue }
        }
        
        showAlert(title: "Oooooops!😱", message: "Your login or password is wrong")
        passwordTFOutlet.text = ""
    }
    
    @IBAction func forgotCredentialsAction() {
        let users = User.getUserData()

        var availableUsers: [String] = []
        var availablePasswords: [String] = []
        
        for user in users {
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
    
//    @IBAction func unwindSegue(segue: UIStoryboardSegue) {
//        guard let registrationVC = segue.source as? RegistrationViewController
//            else { return }
//        guard let newUserName = registrationVC.newUserNameRegistration.text,
//            !newUserName.isEmpty else { return }
//        guard let newPassword = registrationVC.newPasswordRegistration.text,
//            !newPassword.isEmpty else { return }
//        User.addNewUser(name: newUserName, password: newPassword)
//
//            showAlert(title: "Password is empty", message: "Please enter password")
//            return
//        }
//        
//        guard let user = User.authorizationCheck(username: userName, password: password) else {
//            showAlert(title: "User not found", message: "Please try again or register")
//            return
//        }
//        performSegue(withIdentifier: "logIn", sender: user)
//
//    }
    
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

// MARK: - Set background color
extension AuthorizationViewController {
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
