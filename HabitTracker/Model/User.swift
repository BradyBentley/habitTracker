//
//  User.swift
//  HabitTracker
//
//  Created by Brady Bentley on 1/17/19.
//  Copyright © 2019 HabitGroup. All rights reserved.
//

import Foundation

class User {
    // MARK: - Properties
    let uuid: String
    var habits: [Habit]
    
    // MARK: - Initialization
    init(uuid: String, habits: [Habit] = []){
        self.uuid = uuid
        self.habits = habits
    }
}
