//
//  NewHabitNavigationController.swift
//  HabitTracker
//
//  Created by David Truong on 1/31/19.
//  Copyright © 2019 HabitGroup. All rights reserved.
//

import UIKit

class NewHabitNavigationController: UINavigationController {
    
    // MARK: - Dismiss keyboard gesture
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
        tapGesture.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tapGesture)
    }
    
    @objc func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
}
