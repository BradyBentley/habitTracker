//
//  ViewControllerExtension.swift
//  HabitTracker
//
//  Created by DevMountain on 2/19/19.
//  Copyright © 2019 HabitGroup. All rights reserved.
//

import UIKit

extension UIViewController {
  
    func presentSimpleAlertWith(title: String, body: String?){
      let alertController = UIAlertController(title: title, message: body, preferredStyle: .alert)
      let okayAction = UIAlertAction(title: "Okay", style: .cancel, handler: nil)
      alertController.addAction(okayAction)
      self.present(alertController, animated: true, completion: nil)
    }
    
    func presentAreYouSureAlert(title: String, body: String?, completion: @escaping (UIAlertAction) -> ()){
      let alertController = UIAlertController(title: title, message: body, preferredStyle: .alert)
      let okayAction = UIAlertAction(title: "Yes", style: .default, handler: completion)
      let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
      alertController.addAction(okayAction)
      alertController.addAction(cancelAction)
      self.present(alertController, animated: true, completion: nil)
    }
}
