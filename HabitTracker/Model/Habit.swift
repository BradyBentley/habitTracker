//
//  Habit.swift
//  HabitTracker
//
//  Created by Brady Bentley on 1/17/19.
//  Copyright © 2019 HabitGroup. All rights reserved.
//

import Foundation

typealias CheckIn = Date

class Habit {
    // MARK: - Properties
    var isNewHabit: Bool
    var category: String
    var habitDescription: String
    var startingDate: Date
    var days: Int
    var daysCompleted: [CheckIn]
    var weeks: Int
    var timeReminder: [TimeReminder]
    var locationReminder: [LocationReminder]
    var daysCheckedIn: Int
    
    // MARK: - CodingKeys
    enum habitKeys {
        static let isNewHabitKey = "isNewHabit"
        static let categoryKey = "category"
        static let habitDescriptionKey = "habitDescription"
        static let startingDateKey = "startingDate"
        static let daysKey = "days"
        static let daysCompletedKey = "daysCompleted"
        static let weeksKey = "weeks"
        static let timeReminderKey = "timeReminder"
        static let locationReminderKey = "locationReminder"
        static let daysCheckedInKey = "daysCheckedInKey"
        static let userKey = "Users"
        static let habitsKey = "Habits"
    }
    
    // MARK: - Initialization
    init(isNewHabit: Bool, category: String, habitDescription: String, days: Int, weeks: Int, timeReminder: [TimeReminder] = [], locationReminder: [LocationReminder] = [], daysCompleted: [CheckIn] = [], startingDate: Date = Date(), daysCheckedIn: Int = 0){
        self.isNewHabit = isNewHabit
        self.category = category
        self.habitDescription = habitDescription
        self.days = days
        self.weeks = weeks
        self.timeReminder = timeReminder
        self.locationReminder = locationReminder
        self.daysCompleted = daysCompleted
        self.startingDate = startingDate
        self.daysCheckedIn = daysCheckedIn
    }
    
    convenience init?(firebaseDictionary: [String: Any]) {
        guard let isNewHabit = firebaseDictionary[Habit.habitKeys.isNewHabitKey] as? Bool,
        let category = firebaseDictionary[Habit.habitKeys.categoryKey] as? String,
        let habitDescription = firebaseDictionary[Habit.habitKeys.habitDescriptionKey] as? String,
        let days = firebaseDictionary[Habit.habitKeys.daysKey] as? Int,
        let weeks = firebaseDictionary[Habit.habitKeys.weeksKey] as? Int,
        let timeReminder = firebaseDictionary[Habit.habitKeys.timeReminderKey] as? [TimeReminder],
        let locationReminder = firebaseDictionary[Habit.habitKeys.locationReminderKey] as? [LocationReminder],
        let daysCompleted = firebaseDictionary[Habit.habitKeys.daysCompletedKey] as? [CheckIn],
        let daysCheckedIn = firebaseDictionary[Habit.habitKeys.daysCheckedInKey] as? Int,
        let startingDate = firebaseDictionary[Habit.habitKeys.startingDateKey] as? Date else { return nil }
        self.init(isNewHabit: isNewHabit, category: category, habitDescription: habitDescription, days: days, weeks: weeks, timeReminder: timeReminder, locationReminder: locationReminder, daysCompleted: daysCompleted, startingDate: startingDate, daysCheckedIn: daysCheckedIn)
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
                habitKeys.locationReminderKey: locationReminder,
                habitKeys.daysCompletedKey: daysCompleted,
                habitKeys.startingDateKey: startingDate,
                habitKeys.daysCheckedInKey: daysCheckedIn
        ]
    }
    
    var completion: Int {
        return (daysCheckedIn / days) * 100
    }
}

// MARK: - Equatable
extension Habit: Equatable {
    static func == (lhs: Habit, rhs: Habit) -> Bool {
        return lhs.category == rhs.category && lhs.habitDescription == rhs.habitDescription && lhs.isNewHabit == rhs.isNewHabit && lhs.days == rhs.days && lhs.weeks == rhs.weeks && lhs.daysCompleted == rhs.daysCompleted && lhs.startingDate == rhs.startingDate
    }
}

extension Date {
    var asPrettyString: String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.dateStyle = .medium
        return formatter.string(from: self)
    }
}
