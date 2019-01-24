//
//  HabitController.swift
//  HabitTracker
//
//  Created by Brady Bentley on 1/17/19.
//  Copyright © 2019 HabitGroup. All rights reserved.
//

import Foundation

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
        completion(true)
    }
    
    func createTimeReminder(habit: Habit, day: Date, time: Date, reminderText: String, completion: @escaping SuccessCompletion) {
        let newTimeReminder = TimeReminder(time: time, day: day, reminderText: reminderText)
        habit.timeReminder.append(newTimeReminder)
        completion(true)
    }
    
    func createLocationReminder(habit: Habit, latitude: Float, longitude: Float, reminderText: String, completion: @escaping SuccessCompletion) {
        let newLocationReminder = LocationReminder(latitude: latitude, longitude: longitude, reminderText: reminderText)
        habit.locationReminder.append(newLocationReminder)
        completion(true)
    }
    
    // Update
    func updateHabit(habit: Habit, habitName: String, days: Int, weeks: Int, completion: @escaping SuccessCompletion) {
        habit.days = days
        habit.weeks = weeks
        completion(true)
    }
    
    func updateTimeReminder(timeReminder: TimeReminder, day: Date, time: Date, reminderText: String, completion: @escaping SuccessCompletion) {
        timeReminder.day = day
        timeReminder.time = time
        timeReminder.reminderText = reminderText
        completion(true)
    }
    
    func updateLocationReminder(locationReminder: LocationReminder, latitude: Float, longitude: Float, reminderText: String, completion: @escaping SuccessCompletion) {
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
