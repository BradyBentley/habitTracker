//
//  ReminderViewController.swift
//  HabitTracker
//
//  Created by Karissa McDaris on 1/18/19.
//  Copyright © 2019 HabitGroup. All rights reserved.
//

import UIKit
import UserNotifications

class ReminderViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, DeleteButtonTableViewCellDelegate, TextFieldTableViewCellDelegate, TimeReminderScheduler, LocationReminderScheduler {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timeBasedRemindersTableView.dataSource = self
        timeBasedRemindersTableView.delegate = self
        locationBasedRemindersTableView.dataSource = self
        locationBasedRemindersTableView.delegate = self
        getAuthorizationStatus()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        timeBasedRemindersTableView.reloadData()
        locationBasedRemindersTableView.reloadData()
    }
    
    // MARK: - Properties
    
    @IBOutlet weak var timeBasedRemindersTableView: UITableView!
    @IBOutlet weak var locationBasedRemindersTableView: UITableView!
    
    var habit: Habit?
    var authorizationStatus: UNAuthorizationStatus?
    
    // MARK: - Button actions
    
    @IBAction func doneButtonPushed(_ sender: Any) {
        guard let habit = habit else { return }
        
        if authorizationStatus == .denied {
            // MARK: - Notification disabled alert
            DispatchQueue.main.async {
            let alertController = UIAlertController(title: "Notifications Disabled", message: "Please turn on notifications in settings to receive time or location alerts", preferredStyle: .alert)
            let settingsAction = UIAlertAction(title: "Settings", style: .default) { (_) -> Void in
                guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else { return }
                
                if UIApplication.shared.canOpenURL(settingsUrl) {
                    UIApplication.shared.open(settingsUrl, completionHandler: { (_) in
                        self.dismiss(animated: false, completion: nil)
                    })
                }
            }
            let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: { (_) in
                self.dismiss(animated: true, completion: nil)
            })
            alertController.addAction(cancelAction)
            alertController.addAction(settingsAction)
            self.present(alertController, animated: true, completion: nil)
            }
        } else {
            HabitController.shared.createHabit(isNewHabit: habit.isNewHabit, category: habit.category, habitDescription: habit.habitDescription, days: habit.days, weeks: habit.weeks) { (_) in
                for timeReminder in habit.timeReminder {
                    HabitController.shared.createTimeReminder(habit: habit, day: timeReminder.day, time: timeReminder.time, reminderText: timeReminder.reminderText) { (_) in
                        self.scheduleUserNotifications(for: timeReminder)
                    }
                }
                for locationReminder in habit.locationReminder {
                    HabitController.shared.createLocationReminder(habit: habit, latitude: locationReminder.longitude, longitude: locationReminder.longitude, locationName: locationReminder.locationName, remindOnEntryOrExit: locationReminder.remindOnEntryOrExit, reminderText: locationReminder.reminderText) { (_) in
                        self.scheduleUserNotifications(for: locationReminder)
                    }
                }
            }
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    // MARK: - Authorization status
    
    func getAuthorizationStatus() {
        UNUserNotificationCenter.current().getNotificationSettings { (settings) in
            self.authorizationStatus = settings.authorizationStatus
        }
    }
    
    // MARK: - Table view data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == timeBasedRemindersTableView {
            return habit?.timeReminder.count ?? 0
        } else {
            return habit?.locationReminder.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == timeBasedRemindersTableView {
            if let cell = timeBasedRemindersTableView.dequeueReusableCell(withIdentifier: "TimeCell", for: indexPath) as? ReminderTableViewCell {
                if let timeReminder = habit?.timeReminder[indexPath.row] {
                    cell.timeReminder = timeReminder
                    cell.deleteButtonDelegate = self
                    cell.textFieldDelegate = self
                    return cell
                }
            }
        } else if tableView == locationBasedRemindersTableView {
            if let cell = locationBasedRemindersTableView.dequeueReusableCell(withIdentifier: "LocationCell", for: indexPath) as? ReminderTableViewCell {
                if let locationReminder = habit?.locationReminder[indexPath.row] {
                    cell.locationReminder = locationReminder
                    cell.deleteButtonDelegate = self
                    cell.textFieldDelegate = self
                    return cell
                }
            }
        }
        return UITableViewCell()
    }
    
    // MARK: - Table view cell delegate
    
    func deleteButtonPushed(cell: ReminderTableViewCell) {
        guard let habit = habit else { return }
        if let timeReminderUUID = cell.timeReminder?.uuid, !timeReminderUUID.isEmpty {
            if let cellIndexPath = timeBasedRemindersTableView.indexPath(for: cell) {
                timeBasedRemindersTableView.beginUpdates()
                habit.timeReminder.remove(at: cellIndexPath.row)
                timeBasedRemindersTableView.deleteRows(at: [cellIndexPath], with: .fade)
                timeBasedRemindersTableView.endUpdates()
            }
        } else {
            if let cellIndexPath = locationBasedRemindersTableView.indexPath(for: cell) {
                locationBasedRemindersTableView.beginUpdates()
                habit.locationReminder.remove(at: cellIndexPath.row)
                locationBasedRemindersTableView.deleteRows(at: [cellIndexPath], with: .fade)
                locationBasedRemindersTableView.endUpdates()
            }
        }
    }
    
    func textFieldTextChanged(cell: ReminderTableViewCell, text: String) {
        guard let habit = habit else { return }
        if let reminder = cell.timeReminder?.uuid, !reminder.isEmpty {
            if let cellIndexPath = timeBasedRemindersTableView.indexPath(for: cell) {
                timeBasedRemindersTableView.beginUpdates()
                habit.timeReminder[cellIndexPath.row].reminderText = text
                timeBasedRemindersTableView.endUpdates()
            }
        } else {
            if let cellIndexPath = locationBasedRemindersTableView.indexPath(for: cell) {
                locationBasedRemindersTableView.beginUpdates()
                habit.locationReminder[cellIndexPath.row].reminderText = text
                locationBasedRemindersTableView.endUpdates()
            }
        }
    }
    
    // MARK: - Navigation

    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "ToSetTimeReminder", authorizationStatus == .authorized {
            return true
        }
        if identifier == "ToSetLocationReminder", authorizationStatus == .authorized {
            return true
        }
        return false
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToSetTimeReminder" {
            if let destinationVC = segue.destination as? SetReminderTableViewController {
                if let habit = habit {
                    destinationVC.habit = habit
                }
            }
        }
        if segue.identifier == "ToSetLocationReminder" {
            if let destinationVC = segue.destination as? LocationBasedReminderViewController {
                if let habit = habit {
                    destinationVC.habit = habit
                }
            }
        }
    }

}
