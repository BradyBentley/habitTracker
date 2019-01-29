//
//  HabitViewController.swift
//  HabitTracker
//
//  Created by Brady Bentley on 1/17/19.
//  Copyright © 2019 HabitGroup. All rights reserved.
//

import UIKit
import Charts

class HabitDetailViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var habitDescriptionLabel: UILabel!
    @IBOutlet weak var successLabel: UILabel!
    @IBOutlet weak var percentageCompletionLabel: UILabel!
    @IBOutlet weak var habitReminderTableView: UITableView!
    @IBOutlet weak var progressChartView: LineChartView!
    
    // MARK: - Properties
    var habit: Habit?

    
    // MARK: - ViewLife Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        ///UCOMMENT BELOW
        //cell.textLabel?.text = REMINDER TITLE
        //cell.detailTextLabel?.text = REMINDER DATES
    
    }
    // MARK: - Actions
    
    // MARK: - Setup
    func updateViews(){
        guard let habit = habit else { return }
        habitDescriptionLabel.text = habit.habitDescription
        successLabel.text = habit.category
        iconImageView.image = UIImage(named: "\(habit.category)Progress")
        percentageCompletionLabel.text = "\(Int(habit.completion))%"
        setChartData(weeks: LineChartController.shared.weeks, completionPercent: habit.completionPercent)
        setUpLineChart()
    }
    
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToEditHabitDetail" {
            let destinationVC = segue.destination as? EditHabitViewController
            destinationVC?.habit = habit
        }
    }
}

extension HabitDetailViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // TODO: number of rows for reminders
        
        var count = 0
        
        if tableView == habitReminderTableView {
            
            count = habit?.timeReminder.count ?? 0
        }
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell!
        
        if tableView == habitReminderTableView {
            cell = tableView.dequeueReusableCell(withIdentifier: "remindCell", for: indexPath)
        }
        // TODO: Update the reminder cell and populate it with info
        return cell
    }
}

// MARK: - ChartViewDelegate
extension HabitDetailViewController: ChartViewDelegate {
    func setUpLineChart() {
        self.progressChartView.noDataText = "Haven't check in yet"
        let lXAxis = ChartLimitLine(limit: 5, label: "Weeks")
        lXAxis.lineWidth = 5
        lXAxis.labelPosition = .rightBottom
        lXAxis.valueFont = .systemFont(ofSize: 10)
        progressChartView.xAxis.drawGridLinesEnabled = false
        progressChartView.xAxis.labelPosition = .bottom
        progressChartView.xAxis.axisMinimum = 0
        progressChartView.xAxis.axisLineColor = .darkGray
        progressChartView.xAxis.gridColor = .darkGray
        progressChartView.xAxis.granularity = 1
        progressChartView.xAxis.granularityEnabled = true
        progressChartView.xAxis.labelCount = 5
        let leftAxis = progressChartView.leftAxis
        leftAxis.removeAllLimitLines()
        leftAxis.axisMaximum = 105
        leftAxis.axisMinimum = 0
        leftAxis.drawLimitLinesBehindDataEnabled = true
        progressChartView.rightAxis.enabled = false
        progressChartView.legend.enabled = false
    }
    
    
    func setChartData(weeks: [String], completionPercent: [Double]) {
        let values = (0..<weeks.count).map { (i) -> ChartDataEntry in
            let val = completionPercent
            return ChartDataEntry(x: Double(i) + 1, y: val[i])
        }
        let set1: LineChartDataSet = LineChartDataSet(values: values, label: nil)
        guard let habit = habit else { return }
        set1.axisDependency = .left
        set1.setColor(UIColor(named: "\(habit.category)Color") ?? .red, alpha: 0.5)
        set1.setCircleColor(UIColor(named: "\(habit.category)Color") ?? .red)
        set1.lineWidth = 2.0
        set1.circleRadius = 6.0
        set1.fillColor = UIColor.red
        set1.circleHoleColor = UIColor.red
        
        let data = LineChartData(dataSet: set1)
        self.progressChartView.data = data
    }
}



