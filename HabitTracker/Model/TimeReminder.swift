//
//  TimeReminder.swift
//  HabitTracker
//
//  Created by Brady Bentley on 1/17/19.
//  Copyright © 2019 HabitGroup. All rights reserved.
//

import Foundation

class TimeReminder {
    var time: Date
    var day: Date
    var reminderText: String
    
    init(time: Date, day: Date, reminderText: String){
        self.time = time
        self.day = day
        self.reminderText = reminderText
    }
}

// MARK: - Equatable
extension TimeReminder: Equatable {
    static func == (lhs: TimeReminder, rhs: TimeReminder) -> Bool {
        return lhs.day == rhs.day && lhs.time == rhs.time && lhs.reminderText == rhs.reminderText
    }
}
