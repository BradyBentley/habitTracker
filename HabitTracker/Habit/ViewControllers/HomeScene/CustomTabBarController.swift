//
//  CustomTabBarController.swift
//  HabitTracker
//
//  Created by Karissa McDaris on 1/29/19.
//  Copyright © 2019 HabitGroup. All rights reserved.
//

import UIKit

class CustomTabBarController: UITabBarController {
    
    var homeTabButton: UITabBarItem!
    var progressTabButton: UITabBarItem!
    var checkInTabButton: UIButton!
    let tabBarHeight: CGFloat = 70
    let checkInSB = UIStoryboard(name: "CheckInPopUp", bundle: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        homeTabButton = UITabBarItem()
        homeTabButton.title = ""
        progressTabButton = UITabBarItem()
        progressTabButton.title = ""

        setUpTabBarElements()

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let progressSB = UIStoryboard(name: "Progress", bundle: nil)
        
        let habitVC = storyboard.instantiateViewController(withIdentifier: "AddHabitViewController") as! AddHabitViewController
        habitVC.tabBarItem = homeTabButton
        let embedHabitVC = UINavigationController(rootViewController: habitVC)

        let checkInVC = checkInSB.instantiateViewController(withIdentifier: "HabitCheckInViewController") as! HabitCheckInViewController

        let progressVC = progressSB.instantiateViewController(withIdentifier: "HabitProgressDetailViewController") as! HabitProgressDetailViewController
        progressVC.tabBarItem = progressTabButton
        
        self.viewControllers = [embedHabitVC, checkInVC, progressVC]

        setUpMiddleButton()
    }

    override func viewWillLayoutSubviews() {
        var tabFrame = self.tabBar.frame
        tabFrame.size.height = 100
        tabFrame.origin.y = self.view.frame.size.height - 80
        self.tabBar.frame = tabFrame
    }

    func setUpMiddleButton() {
        
        let width : CGFloat = self.view.frame.size.width/5

        let height = tabBarHeight
        
        checkInTabButton = UIButton(frame: CGRect(x: 0.0, y: 0.0, width: width, height: height + 90))
        var menuButtonFrame = checkInTabButton.frame
        menuButtonFrame.origin.y = self.view.bounds.height - menuButtonFrame.height
        
        menuButtonFrame.origin.x = self.view.bounds.width/2 - menuButtonFrame.size.width/2
        
        checkInTabButton.frame = menuButtonFrame

        checkInTabButton.backgroundColor = UIColor.clear
        self.view.addSubview(checkInTabButton)
        
        checkInTabButton.setImage(UIImage(named: "1")?.withRenderingMode(.alwaysOriginal), for: UIControl.State.normal)

        self.tabBar.setNeedsDisplay()
        
        self.tabBar.layoutIfNeeded()
        self.view.layoutIfNeeded()
        checkInTabButton.addTarget(self, action: #selector(checkInButtonTapped(sender:)), for: .touchUpInside)
    }
    
    func setUpTabBarElements() {

        self.homeTabButton.image = UIImage(named:"4")?.withRenderingMode(.alwaysOriginal)
        
        self.homeTabButton.selectedImage = UIImage(named: "6")?.withRenderingMode(.alwaysOriginal)
        
        self.progressTabButton.image = UIImage(named: "11")?.withRenderingMode(.alwaysOriginal)
        
        self.progressTabButton.selectedImage = UIImage(named: "8")?.withRenderingMode(.alwaysOriginal)
    }
    
    @objc func checkInButtonTapped(sender: UIButton) {
        let modalVC = checkInSB.instantiateViewController(withIdentifier: "HabitCheckInViewController")
        modalVC.modalPresentationStyle = .overCurrentContext
        self.present(modalVC, animated: true, completion: nil)
        
    }
}
