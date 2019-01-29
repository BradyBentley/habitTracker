//
//  LineChartController.swift
//  HabitTracker
//
//  Created by Brady Bentley on 1/28/19.
//  Copyright © 2019 HabitGroup. All rights reserved.
//

import Foundation
import Charts

class LineChartController {
    // MARK: - Properties
    static let shared = LineChartController()
    var habit: Habit?
    let weeks: [String] = ["1", "2", "3", "4"]
    var completionPercent: [Double] = []
    
    func addWeeksProgressToArray(habit: Habit, completion: @escaping SuccessCompletion){
        var nextWeeksDate = habit.startingDate.addingTimeInterval(604800)
        let today = Date()
        if today.dateWithoutTime > nextWeeksDate.dateWithoutTime {
            habit.completionPercent.append(habit.completion)
            habit.completionPercent.remove(at: 4)
            self.completionPercent = habit.completionPercent
            nextWeeksDate = habit.startingDate
        }
    }
}
