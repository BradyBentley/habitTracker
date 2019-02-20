//
//  SetReminderTableViewController.swift
//  HabitTracker
//
//  Created by David Truong on 1/22/19.
//  Copyright © 2019 HabitGroup. All rights reserved.
//

import UIKit
import UserNotifications

class SetReminderTableViewController: UITableViewController, UITextFieldDelegate, TimeReminderScheduler {

    override func viewDidLoad() {
        super.viewDidLoad()
        reminderTextField.delegate = self
        updateView()
    }

    // MARK: - Properties
    
    @IBOutlet weak var timePicker: UIDatePicker!
    @IBOutlet weak var reminderTextField: UITextField!
    
    var habit: Habit?
    var reminder: TimeReminder?
    var addingNewHabit: Bool?
    var weekdays: [Int] = []
    
    func updateView() {
        guard let timeReminder = reminder else { return }
        timePicker.date = timeReminder.time
        weekdays = timeReminder.day
        reminderTextField.text = timeReminder.reminderText
    }
    
    // MARK: - Button actions
    
    @IBAction func saveButtonPushed(_ sender: Any) {
        guard let habit = habit, weekdays.count != 0,
            let addingNewHabit = addingNewHabit,
            let reminderText = reminderTextField.text else {
              self.presentSimpleAlertWith(title: "Whoops", body: "You must select at least one day")
              return
      }
        
        let time = timePicker.date
        let timeReminder = TimeReminder(time: time, day: weekdays, reminderText: reminderText)
        
        if !addingNewHabit {
            if let reminder = reminder {
                reminder.time = timePicker.date
                reminder.day = weekdays
                reminder.reminderText = reminderText
                HabitController.shared.updateTimeReminder(habit: habit, timeReminder: reminder) { (_) in
                    self.scheduleUserNotifications(for: timeReminder)
                }
            } else {
                HabitController.shared.createTimeReminder(habit: habit, day: weekdays, time: time, reminderText: reminderText, completion: { (_) in
                    self.scheduleUserNotifications(for: timeReminder)
                })
            }
        } else {
            habit.timeReminder.append(timeReminder)
        }
        
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        if weekdays.contains(indexPath.row) {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        return cell
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if weekdays.contains(indexPath.row) {
            if let index = weekdays.index(of: indexPath.row) {
                weekdays.remove(at: index)
                tableView.cellForRow(at: indexPath)?.accessoryType = .none
            }
        } else {
            weekdays.append(indexPath.row)
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
    }
    
    // MARK: - Textfield delegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

}
