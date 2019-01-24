//
//  ReminderViewController.swift
//  HabitTracker
//
//  Created by Karissa McDaris on 1/18/19.
//  Copyright © 2019 HabitGroup. All rights reserved.
//

import UIKit

class ReminderViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, DeleteButtonTableViewCellDelegate {
    
    override func viewDidLoad() {
        timeBasedRemindersTableView.dataSource = self
        timeBasedRemindersTableView.delegate = self
        locationBasedRemindersTableView.dataSource = self
        locationBasedRemindersTableView.delegate = self
        super.viewDidLoad()
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

    // MARK: - Table view data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == timeBasedRemindersTableView {
            return habit?.timeReminder?.count ?? 0
        } else {
            return habit?.locationReminder?.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == timeBasedRemindersTableView {
            if let cell = timeBasedRemindersTableView.dequeueReusableCell(withIdentifier: "TimeCell", for: indexPath) as? ReminderTableViewCell {
                if let timeReminder = habit?.timeReminder?[indexPath.row] {
                    cell.timeReminder = timeReminder
                    cell.delegate = self
                    return cell
                }
            }
        } else if tableView == locationBasedRemindersTableView {
            if let cell = locationBasedRemindersTableView.dequeueReusableCell(withIdentifier: "LocationCell", for: indexPath) as? ReminderTableViewCell {
                if let locationReminder = habit?.locationReminder?[indexPath.row] {
                    cell.locationReminder = locationReminder
                    cell.delegate = self
                    return cell
                }
            }
        }
        return UITableViewCell()
    }
    
    // MARK: - Delete button table view cell delegate
    
    func deleteButtonPushed(cell: ReminderTableViewCell) {
        if let habit = habit, let reminder = cell.timeReminder?.uuid, !reminder.isEmpty {
            if let cellIndexPath = timeBasedRemindersTableView.indexPath(for: cell) {
                timeBasedRemindersTableView.beginUpdates()
                habit.timeReminder?.remove(at: cellIndexPath.row)
                timeBasedRemindersTableView.deleteRows(at: [cellIndexPath], with: .fade)
                timeBasedRemindersTableView.endUpdates()
            }
        } else {
            if let cellIndexPath = locationBasedRemindersTableView.indexPath(for: cell) {
                locationBasedRemindersTableView.beginUpdates()
                habit?.locationReminder?.remove(at: cellIndexPath.row)
                locationBasedRemindersTableView.deleteRows(at: [cellIndexPath], with: .fade)
                locationBasedRemindersTableView.endUpdates()
            }
        }
    }
    
    // MARK: - Navigation

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
