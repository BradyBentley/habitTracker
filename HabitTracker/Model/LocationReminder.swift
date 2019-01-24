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
    let uuid: String
    
    init(latitude: Float, longitude: Float, reminderText: String, uuid: String = UUID().uuidString) {
        self.latitude = latitude
        self.longitude = longitude
        self.reminderText = reminderText
        self.uuid = uuid
    }
    
}

// MARK: - Equatable
extension LocationReminder: Equatable {
    static func == (lhs: LocationReminder, rhs: LocationReminder) -> Bool {
        return lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude && lhs.reminderText == rhs.reminderText
    }
}
