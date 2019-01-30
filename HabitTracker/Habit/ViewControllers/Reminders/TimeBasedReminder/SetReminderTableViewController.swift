//
//  SetReminderTableViewController.swift
//  HabitTracker
//
//  Created by David Truong on 1/22/19.
//  Copyright © 2019 HabitGroup. All rights reserved.
//

import UIKit

class SetReminderTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Properties
    
    @IBOutlet weak var timePicker: UIDatePicker!
    
    var habit: Habit?
    var weekdays: [Int] = []
    
    // MARK: - Button actions
    
    @IBAction func saveButtonPushed(_ sender: Any) {
        guard let habit = habit, weekdays.count != 0 else { return }
        
        let time = timePicker.date
        let timeReminder = TimeReminder(time: time, day: weekdays, reminderText: "")
        habit.timeReminder.append(timeReminder)
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

}
