//
//  LocationReminder.swift
//  HabitTracker
//
//  Created by Brady Bentley on 1/17/19.
//  Copyright © 2019 HabitGroup. All rights reserved.
//

import UIKit
import UserNotifications

class LocationReminder {
    
    var latitude: Double
    var longitude: Double
    var locationName: String
    var remindOnEntryOrExit: Int // 0 for entry, 1 for exit, 2 for both
    var reminderText: String
    let uuid: String
    
    init(latitude: Double, longitude: Double, locationName: String, remindOnEntryOrExit: Int, reminderText: String, uuid: String = UUID().uuidString) {
        self.latitude = latitude
        self.longitude = longitude
        self.locationName = locationName
        self.remindOnEntryOrExit = remindOnEntryOrExit
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
