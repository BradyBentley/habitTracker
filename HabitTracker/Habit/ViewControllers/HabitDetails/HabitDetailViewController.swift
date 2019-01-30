//
//  HabitViewController.swift
//  HabitTracker
//
//  Created by Brady Bentley on 1/17/19.
//  Copyright © 2019 HabitGroup. All rights reserved.
//

import UIKit

class HabitDetailViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var habitDescriptionLabel: UILabel!
    @IBOutlet weak var successLabel: UILabel!
    @IBOutlet weak var percentageCompletionLabel: UILabel!
    @IBOutlet weak var habitReminderTableView: UITableView!
    @IBOutlet weak var habitLocationTableView: UITableView!
    
    // MARK: - Properties
    
    var habit: Habit?
    
    let timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        return formatter
    }()
    
    // MARK: - ViewLife Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        habitReminderTableView.dataSource = self
        habitReminderTableView.delegate = self
        habitLocationTableView.dataSource = self
        habitLocationTableView.delegate = self
        navigationItem.leftBarButtonItem?.title = "Back"
        updateViews()
    }
    
    // MARK: - Actions
    
    @IBAction func doneButtonPushed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Setup
    func updateViews() {
        guard let habit = habit else { return }
        habitDescriptionLabel.text = habit.habitDescription
        successLabel.text = habit.category.uppercased()
        iconImageView.image = UIImage(named: "\(habit.category)Progress")
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToEditHabitDetail" {
            if let destinationVC = segue.destination as? EditHabitViewController {
                if let habit = habit {
                    destinationVC.habit = habit
                }
            }
        }
    }
}

extension HabitDetailViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == habitReminderTableView {
            return habit?.timeReminder.count ?? 0
        }
        if tableView == habitLocationTableView {
            return habit?.locationReminder.count ?? 0
        }
        return habit?.daysCompleted.count ?? 0
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let habit = habit else { return UITableViewCell() }
        
        if tableView == habitReminderTableView {
            let cell = habitReminderTableView.dequeueReusableCell(withIdentifier: "TimeReminderCell", for: indexPath)
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
            return cell
        } else if tableView == habitLocationTableView {
            let cell = habitLocationTableView.dequeueReusableCell(withIdentifier: "LocationReminderCell", for: indexPath)
                let locationReminder = habit.locationReminder[indexPath.row]
                cell.textLabel?.text = locationReminder.reminderText
                cell.detailTextLabel?.text = !locationReminder.locationName.isEmpty ? locationReminder.locationName : "\(locationReminder.latitude), \(locationReminder.longitude)"
                return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CheckInCell", for: indexPath)
            return cell
        }
    }
    
}


