//
//  ReminderTableViewCell.swift
//  HabitTracker
//
//  Created by David Truong on 1/23/19.
//  Copyright © 2019 HabitGroup. All rights reserved.
//

import UIKit

class ReminderTableViewCell: UITableViewCell {

    // MARK: - Properties
    
    @IBOutlet weak var timeReminderLabel: UILabel!
    @IBOutlet weak var locationReminderLabel: UILabel!
    @IBOutlet weak var timeReminderTextField: UITextField!
    @IBOutlet weak var locationReminderTextField: UITextField!
    
    var timeReminder: TimeReminder? {
        didSet {
            updateTimeReminderView()
        }
    }
    
    var locationReminder: LocationReminder? {
        didSet {
            updateLocationReminderView()
        }
    }
    
    let timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        return formatter
    }()
    
    var reminder: String = ""
    weak var deleteButtonDelegate: DeleteButtonTableViewCellDelegate?
    weak var textFieldDelegate: TextFieldTableViewCellDelegate?
    
    // MARK: - Update Views
    
    func updateTimeReminderView() {
        guard let timeReminder = timeReminder else { return }
        let time = timeFormatter.string(from: timeReminder.time)
        reminder = time + " - "
        if let days = timeReminder.day {
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
        }
        timeReminderLabel.text = reminder
        timeReminderTextField.text = timeReminder.reminderText
    }
    
    func updateLocationReminderView() {
        guard let locationReminder = locationReminder else { return }
        locationReminderLabel.text = !locationReminder.locationName.isEmpty ? locationReminder.locationName : "\(locationReminder.latitude), \(locationReminder.longitude)"
        locationReminderTextField.text = locationReminder.reminderText
    }
    
    // MARK - Button actions
    
    @IBAction func deleteTimeReminderButtonPushed(_ sender: Any) {
        deleteButtonDelegate?.deleteButtonPushed(cell: self)
    }
    
    @IBAction func deleteLocationReminderButtonPushed(_ sender: Any) {
        deleteButtonDelegate?.deleteButtonPushed(cell: self)
    }
    
    @IBAction func timeReminderSaveButtonPushed(_ sender: Any) {
        if let timeReminderText = timeReminderTextField.text {
            textFieldDelegate?.textFieldTextChanged(cell: self, text: timeReminderText)
        }
    }
    
    @IBAction func locationReminderSaveButtonPushed(_ sender: Any) {
        if let locationReminderText = locationReminderTextField.text {
            textFieldDelegate?.textFieldTextChanged(cell: self, text: locationReminderText)
        }
    }
    
}

protocol DeleteButtonTableViewCellDelegate: class {
    
    func deleteButtonPushed(cell: ReminderTableViewCell)
    
}

protocol TextFieldTableViewCellDelegate: class {
    
    func textFieldTextChanged(cell: ReminderTableViewCell, text: String)
    
}
