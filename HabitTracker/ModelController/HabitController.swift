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
    func createHabit(isNewHabit: Bool, category: String, habitDescription: String, days: Int, weeks: Int, completion: @escaping SuccessCompletion) {
        let newHabit = Habit(isNewHabit: isNewHabit, category: category, habitDescription: habitDescription, days: days, weeks: weeks)
        habits.append(newHabit)
        Firebase.shared.saveHabit(habit: newHabit) { (_) in
        }
        completion(true)
    }
    
    func createTimeReminder(habit: Habit, day: [Int], time: Date, reminderText: String, completion: @escaping SuccessCompletion) {
        let newTimeReminder = TimeReminder(time: time, day: day, reminderText: reminderText)
        habit.timeReminder.append(newTimeReminder)
        completion(true)
    }
    
  func createLocationReminder(habit: Habit, latitude: Double, longitude: Double, locationName: String, reminderText: String, completion: @escaping SuccessCompletion) {
    let newLocationReminder = LocationReminder(latitude: latitude, longitude: longitude, locationName: locationName, remindOnEntryOrExit: 2, reminderText: reminderText)
        habit.locationReminder.append(newLocationReminder)
        completion(true)
    }
    
    // Update
    func updateHabit(habit: Habit, habitName: String, days: Int, weeks: Int, completion: @escaping SuccessCompletion) {
        habit.days = days
        habit.weeks = weeks
        completion(true)
    }
    
    func updateTimeReminder(timeReminder: TimeReminder, day: [Int], time: Date, reminderText: String, completion: @escaping SuccessCompletion) {
        timeReminder.day = day
        timeReminder.time = time
        timeReminder.reminderText = reminderText
        completion(true)
    }
    
    func updateLocationReminder(locationReminder: LocationReminder, latitude: Double, longitude: Double, reminderText: String, completion: @escaping SuccessCompletion) {
        locationReminder.latitude = latitude
        locationReminder.longitude = longitude
        locationReminder.reminderText = reminderText
        completion(true)
    }
    
    // Delete
    func deleteHabit(habit: Habit, completion: @escaping SuccessCompletion) {
        guard let index = habits.index(of: habit) else { completion(false) ; return }
            habits.remove(at: index)
            completion(true)
    }
    
    func deleteTimeReminder(timeReminder: TimeReminder, from habit: Habit, completion: @escaping SuccessCompletion) {
        guard let index = habit.timeReminder.index(of: timeReminder) else { completion(false) ; return }
        habit.timeReminder.remove(at: index)
        completion(true)
    }
    
    func deleteLocationReminder(locationReminder: LocationReminder, from habit: Habit, completion: @escaping SuccessCompletion) {
        guard let index = habit.locationReminder.index(of: locationReminder) else { completion(false) ; return }
        habit.locationReminder.remove(at: index)
        completion(true)
    }
    
}

protocol TimeReminderScheduler {
    
    func scheduleUserNotifications(for timeReminder: TimeReminder)
    func cancelTimeNotifications(for timeReminderUUID: String)
    
}

extension TimeReminderScheduler {
    
    func scheduleUserNotifications(for timeReminder: TimeReminder) {
        guard let days = timeReminder.day else { return }
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
