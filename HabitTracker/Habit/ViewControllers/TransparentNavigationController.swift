//
//  TransparentNavigationController.swift
//  HabitTracker
//
//  Created by DevMountain on 2/20/19.
//  Copyright © 2019 HabitGroup. All rights reserved.
//

import UIKit

class TransparentNavigationController: UINavigationController {
  // MARK: - Properties
  override var preferredStatusBarStyle: UIStatusBarStyle { // Sets the status bar style to be light
    return .lightContent
  }
  
  // MARK: - View Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setupViews()
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
    tapGesture.cancelsTouchesInView = false
    self.view.addGestureRecognizer(tapGesture)
  }
  
  // MARK: - Setup
  func setupViews() {
    navigationBar.setBackgroundImage(UIImage(), for: .default)
    navigationBar.shadowImage = UIImage()
    navigationBar.isTranslucent = true
    view.backgroundColor = .clear
  }
  
  @objc func dismissKeyboard (_ sender: UITapGestureRecognizer) {
    self.view.endEditing(true)
  }
}
