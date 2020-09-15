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

    @IBOutlet var userNameTFOutlet: UITextField!
    @IBOutlet var passwordTFOutlet: UITextField!
    
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
        userNameTFOutlet.delegate = self
        passwordTFOutlet.delegate = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "logIn" else { return }
        let navBarVC = segue.destination as! UINavigationController
        let tabBarVC = navBarVC.topViewController as! TabBarViewController
        tabBarVC.user = sender as? User
    }
    
    // MARK: – IB Actions

    @IBAction func loginButtonAction() {
        guard let userName = userNameTFOutlet.text, !userName.isEmpty else {
            showAlert(title: "Oooooops!😱",
                      message: "Your username field is empty")
            return
        }
        guard let password = passwordTFOutlet.text, !password.isEmpty else {
            showAlert(title: "Oooooops!😱",
                      message: "Your passworld field is empty")
            return
        }
        
        guard let user = User.authorizationCheck(username: userName, password: password) else {
            showAlert(title: "Oooooops!😱",
                      message: "Incorrect login and pass")
            return
        }
        performSegue(withIdentifier: "logIn", sender: user)
    }
    
    @IBAction func unwindSegue(segue: UIStoryboardSegue) {
        guard segue.identifier == "registrationSegue" else {
            return
        }
        
        guard let registrationVC = segue.source as? RegistrationViewController
        else { return }
        
        User.addNewUser(name: registrationVC.newUserNameRegistration.text!,
                        password: registrationVC.newPasswordRegistration.text!)
        
        userNameTFOutlet.text = registrationVC.newUserNameRegistration.text
        passwordTFOutlet.text = registrationVC.newPasswordRegistration.text
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
