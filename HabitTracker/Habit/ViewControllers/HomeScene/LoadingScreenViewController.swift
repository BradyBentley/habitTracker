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
        //dismiss(animated: true, completion: nil)
        

        // Do any additional setup after loading the view.
        Auth.auth().addStateDidChangeListener { (auth, user) in
            if let user = user {
                let uuid = user.uid
                UserController.shared.currentUser = User(uuid: uuid)
                self.performSegue(withIdentifier: "ToMainHabitScreen", sender: nil)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        animateOpeningPage()
        animatingOfShadow()
        //self.present(loginPage!, animated: true, completion: nil)
        //let homeVC = self.storyboard?.instantiateViewController(withIdentifier: "AddHabitViewController") as! AddHabitViewController
        //self.present(homeVC, animated: true, completion: nil)
        //self.presentingViewController?.dismiss(animated: false, completion:nil)
    }
    
    func animateOpeningPage(){
        floatingManAnimation.center.y = view.center.y
        
        UIView.animate(withDuration: 1.5, delay: 0,  options: [.repeat, .autoreverse], animations: ({
            self.floatingManAnimation.center.y = self.view.center.y + 10
            
        }), completion: nil)
    }
    
    func animatingOfShadow() {
        
        Timer.scheduledTimer(withTimeInterval: 10, repeats: false) { (_) in
            self.present(self.loginPage!, animated: true, completion: nil)
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
            print("Successfully loaded login screen")
        })
        
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
