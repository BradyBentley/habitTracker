//
//  DateExtension.swift
//  HabitTracker
//
//  Created by Brady Bentley on 1/28/19.
//  Copyright © 2019 HabitGroup. All rights reserved.
//

import Foundation

extension Date {
    var dateWithoutTime: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .none
        return formatter.string(from: self)
        
    }
}
