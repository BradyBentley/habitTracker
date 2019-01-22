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
    var isAnonymousUser: Bool
    var habits: [Habit]
    
    // MARK: - Initialization
    init(uuid: String, habits: [Habit] = [], isAnonymousUser: Bool = true){
        self.uuid = uuid
        self.habits = habits
        self.isAnonymousUser = isAnonymousUser
    }
}
