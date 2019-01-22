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
    let day: Date
    let reminderText: String
    
    init(time: Date, day: Date, reminderText: String){
        self.time = time
        self.day = day
        self.reminderText = reminderText
    }
}
