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
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    // MARK: - Actions
    @IBAction func unwindToLogInVC(segue: UIStoryboardSegue){
        
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
