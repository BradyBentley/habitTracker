//
//  HabitController.swift
//  HabitTracker
//
//  Created by Brady Bentley on 1/17/19.
//  Copyright © 2019 HabitGroup. All rights reserved.
//

import Foundation
import CoreLocation
import UserNotifications

typealias SuccessCompletion = (_ success: Bool) -> Void
class HabitController {
    // MARK: - Properties
    static let shared = HabitController()
    var habits: [Habit] = []
    
    // MARK: - CRUD
    // Create
    func createHabit(isNewHabit: Bool, category: String, habitDescription: String, days: Int, weeks: Int, uuid: String, completion: @escaping SuccessCompletion) {
        let newHabit = Habit(isNewHabit: isNewHabit, category: category, habitDescription: habitDescription, days: days, weeks: weeks, uuid: uuid)
        habits.append(newHabit)
        Firebase.shared.saveHabit(habit: newHabit) { (_) in }
        completion(true)
    }
    
    func createTimeReminder(habit: Habit, day: [Int], time: Date, reminderText: String, completion: @escaping SuccessCompletion) {
        let newTimeReminder = TimeReminder(time: time, day: day, reminderText: reminderText)
        if let indexOfHabit = habits.index(of: habit) {
            habits[indexOfHabit].timeReminder.append(newTimeReminder)
        }
        Firebase.shared.createTimeReminders(habit: habit, timeReminder: newTimeReminder) { (_) in }
        completion(true)
    }
    
    func createLocationReminder(habit: Habit, latitude: Double, longitude: Double, locationName: String, remindOnEntryOrExit: Int, reminderText: String, completion: @escaping SuccessCompletion) {
        let newLocationReminder = LocationReminder(latitude: latitude, longitude: longitude, locationName: locationName, remindOnEntryOrExit: remindOnEntryOrExit, reminderText: reminderText)
        if let indexOfHabit = habits.index(of: habit) {
            habits[indexOfHabit].locationReminder.append(newLocationReminder)
        }
        Firebase.shared.createLocationReminder(habit: habit, locationReminder: newLocationReminder) { (_) in }
        completion(true)
    }
    
    // Update
    func updateHabit(habit: Habit, habitName: String, days: Int, weeks: Int, completion: @escaping SuccessCompletion) {
        if let indexOfHabit = habits.index(of: habit) {
            Firebase.shared.updateHabitOnFirebase(habit: habit, habitDescription: habitName, days: days, weeks: weeks) { (_) in
                self.habits[indexOfHabit].habitDescription = habitName
                self.habits[indexOfHabit].days = days
                self.habits[indexOfHabit].weeks = weeks
            }
        }
        completion(true)
    }
    
    func updateTimeReminder(habit: Habit, timeReminder: TimeReminder, completion: @escaping SuccessCompletion) {
        if let indexOfHabit = habits.index(of: habit) {
            if let indexOfTimeReminder = habits[indexOfHabit].timeReminder.index(of: timeReminder) {
                Firebase.shared.updateTimeReminder(habit: habit, timeReminder: timeReminder, completion: { (_) in
                    self.habits[indexOfHabit].timeReminder[indexOfTimeReminder] = timeReminder
                })
            }
        }
        completion(true)
    }
    
    func updateLocationReminder(habit: Habit, locationReminder: LocationReminder, completion: @escaping SuccessCompletion) {
        if let indexOfHabit = habits.index(of: habit) {
            if let indexOfLocationReminder = habits[indexOfHabit].locationReminder.index(of: locationReminder) {
                Firebase.shared.updateLocationReminder(habit: habit, locationReminder: locationReminder, completion: { (_) in
                    self.habits[indexOfHabit].locationReminder[indexOfLocationReminder] = locationReminder
                })
            }
        }
        completion(true)
    }
    
    // Delete
    func deleteHabit(habit: Habit, completion: @escaping SuccessCompletion) {
        guard let index = habits.index(of: habit) else { completion(false) ; return }
        habits.remove(at: index)
        Firebase.shared.deleteHabit(habit: habit) { (_) in }
        completion(true)
    }
    
    func deleteTimeReminder(timeReminder: TimeReminder, from habit: Habit, completion: @escaping SuccessCompletion) {
        guard let indexOfHabit = habits.index(of: habit),
            let indexOfTimeReminder = habit.timeReminder.index(of: timeReminder) else { completion(false) ; return }
        Firebase.shared.deleteTimeReminder(habit: habit, timeReminder: timeReminder) { (_) in
            habit.timeReminder.remove(at: indexOfTimeReminder)
            self.habits[indexOfHabit] = habit
            print("Deleted time reminder")
        }
        completion(true)
    }
    
    func deleteLocationReminder(locationReminder: LocationReminder, from habit: Habit, completion: @escaping SuccessCompletion) {
        guard let indexOfHabit = habits.index(of: habit),
            let indexOfLocationReminder = habit.locationReminder.index(of: locationReminder) else { completion(false) ; return }
        Firebase.shared.deleteLocationReminder(habit: habit, locationReminder: locationReminder) { (_) in
            habit.locationReminder.remove(at: indexOfLocationReminder)
            self.habits[indexOfHabit] = habit
            print("Deleted location reminder")
        }
        completion(true)
    }
    
}

// MARK: - Notification protocols
protocol TimeReminderScheduler {
    
    func scheduleUserNotifications(for timeReminder: TimeReminder)
    func cancelTimeNotifications(for timeReminderUUID: String)
    
}

extension TimeReminderScheduler {
    
    func scheduleUserNotifications(for timeReminder: TimeReminder) {
        let days = timeReminder.day
        // creates the content of the notification
        let content = UNMutableNotificationContent()
        content.title = "It's Habit Time!"
        content.body = timeReminder.reminderText
        content.sound = UNNotificationSound.default
        // sets a trigger for every weekday that user set
        var date = DateComponents()
        let calendar = Calendar.current
        for day in days {
            date.weekday = day + 1
            date.hour = calendar.component(.hour, from: timeReminder.time)
            date.minute = calendar.component(.minute, from: timeReminder.time)
            let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: true)
            // schedule the notification using the reminder uuid
            let request = UNNotificationRequest(identifier: timeReminder.uuid, content: content, trigger: trigger)
            UNUserNotificationCenter.current().add(request) { (_) in
                print("User asked to get a local notification")
            }
        }
    }
    
    func cancelTimeNotifications(for timeReminderUUID: String) {
        // removes the scheduled notification using the uuid.
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [timeReminderUUID])
    }
    
}

protocol LocationReminderScheduler {
    
    func scheduleUserNotifications(for locationReminder: LocationReminder)
    func cancelLocationNotifications(for locationReminderUUID: String)
    
}

extension LocationReminderScheduler {
    
    func scheduleUserNotifications(for locationReminder: LocationReminder) {
        // creates the content of the notification
        let content = UNMutableNotificationContent()
        content.title = "It's Habit Location!"
        content.body = locationReminder.reminderText
        content.sound = UNNotificationSound.default
        let coordinate = CLLocationCoordinate2D(latitude: locationReminder.latitude, longitude: locationReminder.longitude)
        let region = CLCircularRegion(center: coordinate, radius: 200.0, identifier: locationReminder.uuid)
        switch locationReminder.remindOnEntryOrExit {
        case 0:
            region.notifyOnEntry = true
            region.notifyOnExit = false
        case 1:
            region.notifyOnEntry = false
            region.notifyOnExit = true
        default:
            region.notifyOnEntry = true
            region.notifyOnExit = true
        }
        let trigger = UNLocationNotificationTrigger(region: region, repeats: true)
        // schedule the notification using the location uuid
        let request = UNNotificationRequest(identifier: locationReminder.uuid, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { (_) in
            print("User asked to get a local notification")
        }
        UNUserNotificationCenter.current().getPendingNotificationRequests { (notifications) in
            print(notifications.count)
        }
    }
    
    func cancelLocationNotifications(for locationReminderUUID: String) {
        // removes the scheduled notification using the uuid.
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [locationReminderUUID])
    }
    
}
