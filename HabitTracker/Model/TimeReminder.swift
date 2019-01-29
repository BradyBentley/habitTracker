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
    var day: [Int]
    var reminderText: String
    let uuid: String
    
    init(time: Date, day: [Int], reminderText: String, uuid: String = UUID().uuidString) {
        self.time = time
        self.day = day
        self.reminderText = reminderText
        self.uuid = uuid
    }
    
    convenience init?(firebaseDictionary: [String: Any]){
        guard let time = firebaseDictionary["time"] as? Date,
        let day = firebaseDictionary["day"] as? [Int],
            let reminderText = firebaseDictionary["reminderText"] as? String else { return nil }
        self.init(time: time, day: day, reminderText: reminderText)
    }
    
}

// MARK: - Equatable
extension TimeReminder: Equatable {
    static func == (lhs: TimeReminder, rhs: TimeReminder) -> Bool {
        return lhs.uuid == rhs.uuid
    }
}

extension TimeReminder {
    var dictionary: [String: Any] {
        return [
            "time": time,
            "day": day,
            "reminderText": reminderText,
            "uuid": uuid
        ]
    }
}
