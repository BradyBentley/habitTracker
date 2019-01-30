//
//  EditHabitViewController.swift
//  HabitTracker
//
//  Created by Karissa McDaris on 1/21/19.
//  Copyright © 2019 HabitGroup. All rights reserved.
//

import UIKit

class EditHabitViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIPickerViewDataSource, UIPickerViewDelegate, TimeReminderScheduler, LocationReminderScheduler {
    
    // MARK: - IBOutlets
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var remindersTableView: UITableView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var dayPickerView: UIPickerView!
    @IBOutlet weak var weekPickerView: UIPickerView!
    
    // MARK: - Properties
    var habit: Habit?
    var days: Int = 1
    var weeks: Int = 1
    
    let timeFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "h:mm a"
    return formatter
    }()
    
    // MARK: - ViewLife Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        dayPickerView.dataSource = self
        dayPickerView.delegate = self
        weekPickerView.dataSource = self
        weekPickerView.delegate = self
        remindersTableView.dataSource = self
        remindersTableView.delegate = self
        updateView()
    }
    
    // MARK: - Setup
    func updateView() {
        guard let habit = habit else { return }
        nameTextField.text = habit.habitDescription
        iconImageView.image = UIImage(named: "\(habit.category)Progress")
        days = habit.days
        weeks = habit.weeks
        dayPickerView.selectRow(days - 1, inComponent: 0, animated: true)
        weekPickerView.selectRow(weeks - 1, inComponent: 0, animated: true)
    }
    
    // MARK: - Action
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let habit = habit,
            let habitName = nameTextField.text, !habitName.isEmpty else { return }
        
        HabitController.shared.updateHabit(habit: habit, habitName: habitName, days: days, weeks: weeks) { (_) in
            if let viewControllers: [UIViewController] = self.navigationController?.viewControllers {
                self.navigationController?.popToViewController(viewControllers[viewControllers.count - 3], animated: true)
            }
        }
    }
    
    @IBAction func deleteButtonTapped(_ sender: Any) {
        guard let habit = habit else {return}
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
        HabitController.shared.deleteHabit(habit: habit) { (_) in
            if let viewControllers: [UIViewController] = self.navigationController?.viewControllers {
                self.navigationController?.popToViewController(viewControllers[viewControllers.count - 3], animated: true)
            }
        }
    }
    

    // MARK: - UIPickerView Source
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == dayPickerView {
            return 7
        } else {
            return 52
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(row + 1)"
    }
    
    // MARK: - UIPickerView Delegate
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == dayPickerView {
            days = row + 1
        } else {
            weeks = row + 1
        }
    }
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return habit?.timeReminder.count ?? 0
        } else {
            return habit?.locationReminder.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let habit = habit else { return UITableViewCell() }
        
        var cell: UITableViewCell
        if indexPath.section == 0 {
            cell = tableView.dequeueReusableCell(withIdentifier: "TimeReminderCell", for: indexPath)
            let timeReminder = habit.timeReminder[indexPath.row]
            let time = timeFormatter.string(from: timeReminder.time)
            var reminder = time + " - "
            let days = timeReminder.day
            for day in days {
                switch day {
                case 0:
                    reminder.append("Sun ")
                case 1:
                    reminder.append("Mon ")
                case 2:
                    reminder.append("Tue ")
                case 3:
                    reminder.append("Wed ")
                case 4:
                    reminder.append("Thu ")
                case 5:
                    reminder.append("Fri ")
                default:
                    reminder.append("Sat ")
                }
            }
            cell.textLabel?.text = timeReminder.reminderText
            cell.detailTextLabel?.text = reminder
        } else {
            cell = tableView.dequeueReusableCell(withIdentifier: "LocationReminderCell", for: indexPath)
            let locationReminder = habit.locationReminder[indexPath.row]
            cell.textLabel?.text = locationReminder.reminderText
            cell.detailTextLabel?.text = locationReminder.locationName
        }
        return cell
    }
    
    // MARK: - Table view delegate
    
}
