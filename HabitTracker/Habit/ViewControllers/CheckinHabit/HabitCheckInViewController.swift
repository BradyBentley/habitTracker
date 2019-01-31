//
//  HabitCheckInViewController.swift
//  HabitTracker
//
//  Created by Karissa McDaris on 1/20/19.
//  Copyright © 2019 HabitGroup. All rights reserved.
//

import UIKit

class HabitCheckInViewController: UIViewController {
    
    // MARK: - IB Outlets
    @IBOutlet weak var CheckInTableView: UITableView!

    // MARK: - Properties
    var habit: Habit?
    
    // MARK: - ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        CheckInTableView.delegate = self
        CheckInTableView.dataSource = self
    }
    
    // MARK: - Action
    @IBAction func exitTappedGesture(_ sender: UITapGestureRecognizer) {
        handleTap(sender: sender)
    }
}

extension HabitCheckInViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CheckInCell", for: indexPath) as! MainCheckInTableViewCell
        let habit = HabitController.shared.habits[indexPath.row]
        cell.habit = habit
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return HabitController.shared.habits.count
    }
}

// MARK: - TapGestureRecognizer
extension HabitCheckInViewController: UIGestureRecognizerDelegate {
    func handleTap(sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            self.dismiss(animated: true) {
                
            }
        }
    }
}
