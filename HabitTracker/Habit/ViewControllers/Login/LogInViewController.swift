//
//  LogInViewController.swift
//  HabitTracker
//
//  Created by Brady Bentley on 1/23/19.
//  Copyright © 2019 HabitGroup. All rights reserved.
//

import UIKit

class LogInViewController: UIViewController {
    // MARK: - Properties
    var isLogInPage: Bool?
    
    // MARK: - IBOutlets
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var alreadyHaveAnLabel: UILabel!
    @IBOutlet weak var switchPageButton: UIButton!
    
    // MARK: - ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        signInButton.layer.cornerRadius = 20
        updateViews()
    }
    
    // MARK: - Actions
    @IBAction func signInButtonTapped(_ sender: Any) {
        self.performSegue(withIdentifier: "ToMainPage", sender: self) // This line is to bypass login, delete later
        /* Uncomment for login
        guard let email = emailTextField.text, let password = passwordTextField.text, let isLogInPage = isLogInPage, !email.isEmpty, !password.isEmpty else { return }
        if isLogInPage == false {
            guard passwordTextField.text == confirmPasswordTextField.text else { return }
            UserController.shared.createUser(email: email, password: password) { (success) in
                if success {
                    DispatchQueue.main.async {
                        self.performSegue(withIdentifier: "ToMainPage", sender: self)
                    }
                }
            }
        } else {
            UserController.shared.signInUser(email: email, password: password) { (success) in
                if success {
                    DispatchQueue.main.async {
                        self.performSegue(withIdentifier: "ToMainPage", sender: self)
                    }
                } else {
                    print("Error")
                }
            }
        }
        */
    }
    
    @IBAction func alreadyHaveAnLabelTapped(_ sender: Any) {
        guard let islogInPage = isLogInPage else { return }
        isLogInPage = !islogInPage
        updateViews()
    }
    
    // MARK: - Setup
    func signInPage() {
        //SignIn Page
        alreadyHaveAnLabel.text = "Already have an account?"
        signInButton.setTitle("Sign Up", for: .normal)
        switchPageButton.setTitle("Log In", for: .normal)
        confirmPasswordTextField.isHidden = false
    }
    
    func logInPage() {
        //LogIn Page
        alreadyHaveAnLabel.text = "Don't have an account?"
        signInButton.setTitle("Log In", for: .normal)
        switchPageButton.setTitle("Sign Up", for: .normal)
        confirmPasswordTextField.isHidden = true
    }
    
    func updateViews() {
        if isLogInPage == false {
            signInPage()
        } else {
            logInPage()
        }
    }
    
}
