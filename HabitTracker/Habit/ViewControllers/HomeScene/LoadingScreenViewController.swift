//
//  LoadingScreenViewController.swift
//  HabitTracker
//
//  Created by Karissa McDaris on 1/31/19.
//  Copyright © 2019 HabitGroup. All rights reserved.
//

import UIKit
import Firebase

class LoadingScreenViewController: UIViewController {
    
    let loginPage = UIStoryboard(name: "Login", bundle: nil).instantiateInitialViewController()
    
    @IBOutlet weak var shadowWidth: NSLayoutConstraint!
    
    @IBOutlet weak var shadowHeight: NSLayoutConstraint!
    
    @IBOutlet weak var floatingManAnimation: UIImageView!
    
    @IBOutlet weak var shrinkingShadowAnimation: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        animateOpeningPage()
        animatingOfShadow()
    }
    
    func animateOpeningPage(){
        floatingManAnimation.center.y = view.center.y
        
        UIView.animate(withDuration: 1.5, delay: 0,  options: [.repeat, .autoreverse], animations: ({
            self.floatingManAnimation.center.y = self.view.center.y + 10
            
        }), completion: nil)
    }
    
    func animatingOfShadow() {
        
        Timer.scheduledTimer(withTimeInterval: 10, repeats: false) { (_) in
            Auth.auth().addStateDidChangeListener { (auth, user) in
                if let user = user {
                    let uuid = user.uid
                    UserController.shared.currentUser = User(uuid: uuid)
                    self.performSegue(withIdentifier: "ToMainHabitScreen", sender: nil)
                } else {
                    self.present(self.loginPage!, animated: true, completion: nil)
                }
            }
        }
    
        shadowWidth.constant = 100
        self.shrinkingShadowAnimation.setNeedsLayout()
        UIView.animate(withDuration: 1.5, delay: 0, options:[.autoreverse, .repeat], animations: ({
            self.shrinkingShadowAnimation.layoutIfNeeded()
        }), completion: nil)
        
        shadowHeight.constant = 21
        self.shrinkingShadowAnimation.setNeedsLayout()
        UIView.animate(withDuration: 1.5, delay: 0, options: [.autoreverse, .repeat], animations: ({
            self.shrinkingShadowAnimation.layoutIfNeeded()
     
        }), completion: { success in
//
            print("Successfully loaded")
        })
        
        
    }

}
