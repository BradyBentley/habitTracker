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
    // MARK: - ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        if Auth.auth().currentUser != nil {
            performSegue(withIdentifier: "ToHomePage", sender: self)
        }
    }
    
    // MARK: - Navigation
    //IIDOO
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destionationVC = segue.destination as? LogInViewController
        if segue.identifier == "ToLogInPage" {
            let isLogInPage = true
            destionationVC?.isLogInPage = isLogInPage
        }
        if segue.identifier == "ToSignUpPage" {
            let isLogInPage = false
            destionationVC?.isLogInPage = isLogInPage
            
        }
    }
}
