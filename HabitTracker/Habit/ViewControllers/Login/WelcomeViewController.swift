//
//  WelcomeViewController.swift
//  HabitTracker
//
//  Created by Brady Bentley on 1/23/19.
//  Copyright © 2019 HabitGroup. All rights reserved.
//

import UIKit
import Firebase

class WelcomeViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var signInButton: UIButton!
    
    // MARK: - ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        logInButton.layer.cornerRadius = 20
        signInButton.layer.cornerRadius = 20
        Auth.auth().addStateDidChangeListener { (auth, user) in
            if let user = user {
                let uuid = user.uid
                UserController.shared.currentUser = User(uuid: uuid)
                self.performSegue(withIdentifier: "ToHomePage", sender: self)
            }
        }
    }
    
    
    
    // MARK: - Navigation
    //IIDOO
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as? LogInViewController
        if segue.identifier == "ToLogInPage" {
            let isLogInPage = true
            destinationVC?.isLogInPage = isLogInPage
        }
        if segue.identifier == "ToSignUpPage" {
            let isLogInPage = false
            destinationVC?.isLogInPage = isLogInPage
        }
    }
    
}
