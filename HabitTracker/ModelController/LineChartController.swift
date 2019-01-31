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
    
    func addWeekProgressToArray(habit: Habit, completion: @escaping SuccessCompletion){
        var nextWeeksDate = habit.startingDate.addingTimeInterval(604800)
        let today = Date()
        if today.dateWithoutTime > nextWeeksDate.dateWithoutTime {
            habit.completionPercent.insert(habit.completion, at: 0)
            habit.completionPercent.remove(at: 4)
            nextWeeksDate = habit.startingDate
        }
    }
    
    func addToAllHabitArrays(habits: [Habit], completion: @escaping SuccessCompletion){
        for habit in habits {
            addWeekProgressToArray(habit: habit) { (success) in
                if success {
                    Firebase.shared.updateCompletePercent(habit: habit, completePercent: habit.completionPercent, completion: { (_) in
                    })
                }
            }
        }
    }
    
    func setup(chartView: LineChartView) {
        chartView.noDataText = "Haven't check in yet"
        let lXAxis = ChartLimitLine(limit: 5, label: "Weeks")
        lXAxis.lineWidth = 5
        lXAxis.labelPosition = .rightBottom
        lXAxis.valueFont = .systemFont(ofSize: 10)
        chartView.xAxis.drawGridLinesEnabled = false
        chartView.xAxis.labelPosition = .bottom
        chartView.xAxis.axisMinimum = 0
        chartView.xAxis.axisLineColor = .darkGray
        chartView.xAxis.gridColor = .darkGray
        chartView.xAxis.granularity = 1
        chartView.xAxis.granularityEnabled = true
        chartView.xAxis.labelCount = 5
        let leftAxis = chartView.leftAxis
        leftAxis.removeAllLimitLines()
        leftAxis.axisMaximum = 105
        leftAxis.axisMinimum = 0
        leftAxis.drawLimitLinesBehindDataEnabled = true
        chartView.rightAxis.enabled = false
        chartView.legend.enabled = false
    }
}
