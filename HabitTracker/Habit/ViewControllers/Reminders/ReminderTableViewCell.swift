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
    weak var delegate: DeleteButtonTableViewCellDelegate?
    
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
    }
    
    func updateLocationReminderView() {
        guard let locationReminder = locationReminder else { return }
        locationReminderLabel.text = "\(locationReminder.latitude), \(locationReminder.longitude)"
    }
    
    // MARK - Button actions
    
    @IBAction func deleteTimeReminderButtonPushed(_ sender: Any) {
        delegate?.deleteButtonPushed(cell: self)
    }
    
    @IBAction func deleteLocationReminderButtonPushed(_ sender: Any) {
        delegate?.deleteButtonPushed(cell: self)
    }
    
}

protocol DeleteButtonTableViewCellDelegate: class {
    
    func deleteButtonPushed(cell: ReminderTableViewCell)
    
}
