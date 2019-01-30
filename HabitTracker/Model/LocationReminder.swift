//
//  LocationReminder.swift
//  HabitTracker
//
//  Created by Brady Bentley on 1/17/19.
//  Copyright © 2019 HabitGroup. All rights reserved.
//

import UIKit

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
    
    convenience init?(firebaseDictionary: [String: Any]){
        guard let latitude = firebaseDictionary["latitude"] as? Double,
            let longitude = firebaseDictionary["longitude"] as? Double,
            let locationName = firebaseDictionary["locationName"] as? String,
            let remindOnEntryOrExit = firebaseDictionary["remindOnEntryOrExit"] as? Int,
            let reminderText = firebaseDictionary["reminderText"] as? String,
            let uuid = firebaseDictionary["uuid"] as? String else { return nil }
        
        self.init(latitude: latitude, longitude: longitude, locationName: locationName, remindOnEntryOrExit: remindOnEntryOrExit, reminderText: reminderText, uuid: uuid)
    }
    
}

// MARK: - Equatable
extension LocationReminder: Equatable {
    static func == (lhs: LocationReminder, rhs: LocationReminder) -> Bool {
        return lhs.uuid == rhs.uuid
    }
}

// MARK: - Converting to Firebase dictionary
extension LocationReminder {
    var dictionary: [String: Any] {
        return [
            "latitude": latitude,
            "longitude": longitude,
            "locationName": locationName,
            "remindOnEntryOrExit": remindOnEntryOrExit,
            "reminderText": reminderText,
            "uuid": uuid
        ]
    }
}
