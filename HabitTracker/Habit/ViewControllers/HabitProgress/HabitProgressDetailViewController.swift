//
//  HabitProgressDetailViewController.swift
//  HabitTracker
//
//  Created by Karissa McDaris on 1/20/19.
//  Copyright © 2019 HabitGroup. All rights reserved.
//

import UIKit
import Charts

class HabitProgressDetailViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var progressTableView: UITableView!
    @IBOutlet weak var progressChartView: LineChartView!
    @IBOutlet weak var checkInPercentageReportLabel: UILabel!
    @IBOutlet weak var viewLabel: UILabel!
    
    // MARK: - Properties
    var habit: Habit?
    var isThisWeek: Bool = true
    let weeks = ["0", "1", "2", "3", "4"]
    let completionPercent: [Double] = [0.0, 50.0, 80.0, 90.0, 100.0]
    
    // MARK: - ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.progressChartView.delegate = self
        progressTableView.delegate = self
        progressTableView.dataSource = self
        setUpLineChart()
        setChartData(weeks: weeks)
        updateViews()
    }
    
    // MARK: - Actions
    @IBAction func thisWeekSwitch(_ sender: Any) {
        isThisWeek = !isThisWeek
        updateViews()
        
    }
    
    // MARK: - Methods
    func updateViews() {
        if isThisWeek {
            checkInPercentageReportLabel.text = "Check-In Percentage Report"
            progressChartView.isHidden = false
            viewLabel.isHidden = false
        } else {
            checkInPercentageReportLabel.text = "Check-Ins This Week"
            progressChartView.isHidden = true
            viewLabel.isHidden = true
            
            
        }
    }
    
}

// MARK: - UITableView
extension HabitProgressDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return HabitController.shared.habits.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProgressHabitCell", for: indexPath) as! ProgressTableViewCell
        let habit = HabitController.shared.habits[indexPath.row]
        cell.habit = habit
        return cell
    }
}

// MARK: - ChartViewDelegate
extension HabitProgressDetailViewController: ChartViewDelegate {
    func setUpLineChart() {
        self.progressChartView.noDataText = "Haven't check in yet"
        let lXAxis = ChartLimitLine(limit: 5, label: "Weeks")
        lXAxis.lineWidth = 5
        lXAxis.labelPosition = .rightBottom
        lXAxis.valueFont = .systemFont(ofSize: 10)
        progressChartView.xAxis.drawGridLinesEnabled = false
        progressChartView.xAxis.labelPosition = .bottom
        progressChartView.xAxis.setLabelCount(4, force: false)
        let leftAxis = progressChartView.leftAxis
        leftAxis.removeAllLimitLines()
        leftAxis.axisMaximum = 105
        leftAxis.axisMinimum = 0
        leftAxis.drawLimitLinesBehindDataEnabled = true
        progressChartView.rightAxis.enabled = false
        progressChartView.legend.enabled = false
    }
    
    
    func setChartData(weeks: [String]) {
        let values = (0..<weeks.count).map { (i) -> ChartDataEntry in
            let val = completionPercent
            return ChartDataEntry(x: Double(i), y: val[i])
        }
        let set1: LineChartDataSet = LineChartDataSet(values: values, label: nil)
        set1.axisDependency = .left
        set1.setColor(UIColor.red, alpha: 0.5)
        set1.setCircleColor(UIColor.red)
        set1.lineWidth = 2.0
        set1.circleRadius = 6.0
        set1.fillColor = UIColor.red
        set1.circleHoleColor = UIColor.red
        
        let data = LineChartData(dataSet: set1)
        self.progressChartView.data = data
    }
}
