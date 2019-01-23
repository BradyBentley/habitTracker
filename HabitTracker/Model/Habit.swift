//
//  Habit.swift
//  HabitTracker
//
//  Created by Brady Bentley on 1/17/19.
//  Copyright © 2019 HabitGroup. All rights reserved.
//

import Foundation

class Habit {
    // MARK: - Properties
    var isNewHabit: Bool
    var category: String
    var habitDescription: String
    var days: Int
    var weeks: Int
    var timeReminder: [TimeReminder]
    var locationReminder: [LocationReminder]
    
    // MARK: - CodingKeys
    enum habitKeys {
        static let isNewHabitKey = "isNewHabit"
        static let categoryKey = "category"
        static let habitDescriptionKey = "habitDescription"
        static let daysKey = "days"
        static let weeksKey = "weeks"
        static let userKey = "Users"
        static let habitsKey = "Habits"
        static let timeReminderKey = "timeReminder"
        static let locationReminderKey = "locationReminder"
    }
    
    // MARK: - Initialization
    init(isNewHabit: Bool, category: String, habitDescription: String, days: Int, weeks: Int, timeReminder: [TimeReminder] = [], locationReminder: [LocationReminder] = []){
        self.isNewHabit = isNewHabit
        self.category = category
        self.habitDescription = habitDescription
        self.days = days
        self.weeks = weeks
        self.timeReminder = timeReminder
        self.locationReminder = locationReminder
    }
    
    convenience init?(firebaseDictionary: [String: Any]) {
        guard let isNewHabit = firebaseDictionary[Habit.habitKeys.isNewHabitKey] as? Bool,
        let category = firebaseDictionary[Habit.habitKeys.categoryKey] as? String,
        let habitDescription = firebaseDictionary[Habit.habitKeys.habitDescriptionKey] as? String,
        let days = firebaseDictionary[Habit.habitKeys.daysKey] as? Int,
            let weeks = firebaseDictionary[Habit.habitKeys.weeksKey] as? Int else { return nil }
        self.init(isNewHabit: isNewHabit, category: category, habitDescription: habitDescription, days: days, weeks: weeks)
    }
}

extension Habit {
    var dictionary: [String: Any] {
        return [habitKeys.isNewHabitKey: isNewHabit,
                habitKeys.categoryKey: category,
                habitKeys.habitDescriptionKey: habitDescription,
                habitKeys.daysKey: days,
                habitKeys.weeksKey: weeks,
                habitKeys.timeReminderKey: timeReminder,
                habitKeys.locationReminderKey: locationReminder
        ]
    }
}

// MARK: - Equatable
extension Habit: Equatable {
    static func == (lhs: Habit, rhs: Habit) -> Bool {
        return lhs.category == rhs.category && lhs.habitDescription == rhs.habitDescription && lhs.isNewHabit == rhs.isNewHabit && lhs.days == rhs.days && lhs.weeks == rhs.weeks
    }
}
