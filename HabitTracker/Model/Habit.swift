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
    var timeReminder: [TimeReminder]?
    var locationReminder: [LocationReminder]?
    
    // MARK: - CodingKeys
    enum habitKeys {
        static let isNewHabitKey = "isNewHabit"
        static let categoryKey = "category"
        static let habitDescriptionKey = "habitDescription"
        static let daysKey = "days"
        static let weeksKey = "weeks"
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
}

extension Habit {
    var dictionary: [String: Any] {
        return [habitKeys.isNewHabitKey: isNewHabit,
                habitKeys.categoryKey: category,
                habitKeys.habitDescriptionKey: habitDescription,
                habitKeys.daysKey: days,
                habitKeys.weeksKey: weeks
        ]
    }
}

// MARK: - Equatable
extension Habit: Equatable {
    static func == (lhs: Habit, rhs: Habit) -> Bool {
        return lhs.category == rhs.category && lhs.habitDescription == rhs.habitDescription && lhs.isNewHabit == rhs.isNewHabit && lhs.days == rhs.days && lhs.weeks == rhs.weeks
    }
}
