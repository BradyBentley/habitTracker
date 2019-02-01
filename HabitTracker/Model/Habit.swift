//
//  Habit.swift
//  HabitTracker
//
//  Created by Brady Bentley on 1/17/19.
//  Copyright © 2019 HabitGroup. All rights reserved.
//

import Foundation
import Firebase

typealias CheckIn = String

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
    var completionPercent: [Double]
    var uuid: String
    
    var timeReminderUUID: [String] = []
    var locationReminderUUID: [String] = []
    var daysCompletedUUID: [String] = []
    
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
        static let completionPercent = "completionPercent"
        static let habitUUIDKey = "uuid"
    }
    
    // MARK: - Initialization
    init(isNewHabit: Bool, category: String, habitDescription: String, days: Int, weeks: Int, timeReminder: [TimeReminder] = [], locationReminder: [LocationReminder] = [], daysCompleted: [CheckIn] = [], startingDate: Date = Date(), daysCheckedIn: Int = 0, completionPercent: [Double] = [0.0, 0.0, 0.0, 0.0], uuid: String = UUID().uuidString) {
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
        self.completionPercent = completionPercent
        self.uuid = uuid
    }
    
    convenience init?(firebaseDictionary: [String: Any]) {
        guard let isNewHabit = firebaseDictionary[Habit.habitKeys.isNewHabitKey] as? Bool,
        let category = firebaseDictionary[Habit.habitKeys.categoryKey] as? String,
        let habitDescription = firebaseDictionary[Habit.habitKeys.habitDescriptionKey] as? String,
        let days = firebaseDictionary[Habit.habitKeys.daysKey] as? Int,
        let weeks = firebaseDictionary[Habit.habitKeys.weeksKey] as? Int,
        let timeReminderUUID = firebaseDictionary[Habit.habitKeys.timeReminderKey] as? [String],
        let locationReminderUUID = firebaseDictionary[Habit.habitKeys.locationReminderKey] as? [String],
        let daysCompleted = firebaseDictionary[Habit.habitKeys.daysCompletedKey] as? [String],
        let daysCheckedIn = firebaseDictionary[Habit.habitKeys.daysCheckedInKey] as? Int,
        let timeStamp = firebaseDictionary[Habit.habitKeys.startingDateKey] as? Timestamp,
        let completionPercent = firebaseDictionary[Habit.habitKeys.completionPercent] as? [Double],
        let uuid = firebaseDictionary[Habit.habitKeys.habitUUIDKey] as? String else { return nil }
        
        let startingDate = timeStamp.dateValue()
        self.init(isNewHabit: isNewHabit, category: category, habitDescription: habitDescription, days: days, weeks: weeks, daysCompleted: daysCompleted, startingDate: startingDate, daysCheckedIn: daysCheckedIn, completionPercent: completionPercent, uuid: uuid)
        
        self.timeReminderUUID = timeReminderUUID
        self.locationReminderUUID = locationReminderUUID
    }
}

// MARK: - Converting to firebase dictionary
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
                habitKeys.daysCheckedInKey: daysCheckedIn,
                habitKeys.completionPercent: completionPercent,
                habitKeys.habitUUIDKey: uuid
        ]
    }
    
    var completion: Double {
        let percentage = Double(Double(daysCheckedIn) / Double(days) * 100)
        return percentage
    }
    
}

// MARK: - Equatable
extension Habit: Equatable {
    static func == (lhs: Habit, rhs: Habit) -> Bool {
        return lhs.category == rhs.category && lhs.habitDescription == rhs.habitDescription && lhs.isNewHabit == rhs.isNewHabit && lhs.days == rhs.days && lhs.weeks == rhs.weeks && lhs.uuid == rhs.uuid
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
