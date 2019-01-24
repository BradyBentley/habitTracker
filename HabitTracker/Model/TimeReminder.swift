//
//  TimeReminder.swift
//  HabitTracker
//
//  Created by Brady Bentley on 1/17/19.
//  Copyright © 2019 HabitGroup. All rights reserved.
//

import Foundation

class TimeReminder {
    
    let time: Date
    let day: [Int]?
    var reminderText: String
    let uuid: String
    
    init(time: Date, day: [Int] = [], reminderText: String, uuid: String = UUID().uuidString) {
        self.time = time
        self.day = day
        self.reminderText = reminderText
        self.uuid = uuid
    }
    
}
