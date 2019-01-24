//
//  LocationReminder.swift
//  HabitTracker
//
//  Created by Brady Bentley on 1/17/19.
//  Copyright © 2019 HabitGroup. All rights reserved.
//

import Foundation

class LocationReminder {
    var latitude: Float
    var longitude: Float
    var reminderText: String
    
    init(latitude: Float, longitude: Float, reminderText: String){
        self.latitude = latitude
        self.longitude = longitude
        self.reminderText = reminderText
    }
}

// MARK: - Equatable
extension LocationReminder: Equatable {
    static func == (lhs: LocationReminder, rhs: LocationReminder) -> Bool {
        return lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude && lhs.reminderText == rhs.reminderText
    }
}
