//
//  AddHabitViewController.swift
//  HabitTracker
//
//  Created by Brady Bentley on 1/17/19.
//  Copyright © 2019 HabitGroup. All rights reserved.
//

import UIKit
import UserNotifications

class AddHabitViewController: UIViewController, TimeReminderScheduler, LocationReminderScheduler {
    // MARK: - IBOutlets
    @IBOutlet weak var habitsTableView: UITableView!
    
    // MARK: - Properties
    
    // MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        habitsTableView.delegate = self
        habitsTableView.dataSource = self
        Firebase.shared.fetchHabits { (success) in
            if success {
                self.habitsTableView.reloadData()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        habitsTableView.reloadData()
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToHabitDetail" {
            guard let indexPath = habitsTableView.indexPathForSelectedRow else { return }
            let destinationVC = segue.destination as? HabitDetailViewController
            let habit = HabitController.shared.habits[indexPath.row]
            destinationVC?.habit = habit
        }
    }
}

// MARK: - UITableView
extension AddHabitViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return HabitController.shared.habits.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HabitCell", for: indexPath) as! HabitTableViewCell
        let habit = HabitController.shared.habits[indexPath.row]
        cell.habit = habit
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let habit = HabitController.shared.habits[indexPath.row]
            for timeReminder in habit.timeReminder {
                HabitController.shared.deleteTimeReminder(timeReminder: timeReminder, from: habit, completion: { (_) in
                    self.cancelTimeNotifications(for: timeReminder.uuid)
                })
            }
            for locationReminder in habit.locationReminder {
                HabitController.shared.deleteLocationReminder(locationReminder: locationReminder, from: habit, completion: { (_) in
                    self.cancelLocationNotifications(for: locationReminder.uuid)
                })
            }
            HabitController.shared.deleteHabit(habit: habit, completion: { (_) in
                self.habitsTableView.deleteRows(at: [indexPath], with: .fade)
            })
        }
    }
    
}
