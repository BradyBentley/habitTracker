//
//  HabitController.swift
//  HabitTracker
//
//  Created by Brady Bentley on 1/17/19.
//  Copyright © 2019 HabitGroup. All rights reserved.
//

import Foundation

typealias successCompletion = (_ success: Bool) -> Void
class HabitController {
    // MARK: - Properties
    static let shared = HabitController()
    var habits: [Habit] = []
    
    // MARK: - CRUD
    // Create
    func createHabit(isNewHabit: Bool, category: String, habitDescription: String, days: Int, weeks: Int, completion: @escaping successCompletion) {
        let newHabit = Habit(isNewHabit: isNewHabit, category: category, habitDescription: habitDescription, days: days, weeks: weeks)
        habits.append(newHabit)
        completion(true)
    }
    
    // Read/Fetch
    // TODO: Write a function to pull the data from firebase
    
    // Update
    func updateHabit(habit: Habit, isNewHabit: Bool, category: String, habitDescription: String, days: Int, weeks: Int, completion: @escaping successCompletion) {
        habit.isNewHabit = isNewHabit
        habit.category = category
        habit.habitDescription = habitDescription
        habit.days = days
        habit.weeks = weeks
        completion(true)
    }
    
    // Delete
    func deleteHabit(habit: Habit, completion: @escaping successCompletion) {
        if let index = habits.index(of: habit) {
            habits.remove(at: index)
            completion(true)
        }
    }
}
