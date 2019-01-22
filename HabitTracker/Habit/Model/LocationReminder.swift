//
//  LocationReminder.swift
//  HabitTracker
//
//  Created by Brady Bentley on 1/17/19.
//  Copyright © 2019 HabitGroup. All rights reserved.
//

import Foundation

class LocationReminder {
    let latitude: Float
    let longitude: Float
    let reminderText: String
    
    init(latitude: Float, longitude: Float, reminderText: String){
        self.latitude = latitude
        self.longitude = longitude
        self.reminderText = reminderText
    }
}
