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
    var isThisWeek: Bool = false
    
    // MARK: - ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.progressChartView.delegate = self
        progressTableView.delegate = self
        progressTableView.dataSource = self
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTableView), name: Notification.Name("habitsUpdatedNotification"), object: nil)
        LineChartController.shared.setup(chartView: progressChartView)
        LineChartController.shared.addToAllHabitArrays(habits: HabitController.shared.habits) { (_) in }
        setChartData(habits: HabitController.shared.habits)
        updateViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        progressTableView.reloadData()
        
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
            progressTableView.reloadData()
            
        } else {
            checkInPercentageReportLabel.text = "Check-Ins This Week"
            progressChartView.isHidden = true
            viewLabel.isHidden = true
            progressTableView.reloadData()
        }
    }
    
    @objc func reloadTableView(){
        if isThisWeek {
            DispatchQueue.main.async {
                self.setChartData(habits: HabitController.shared.habits)
            }
        } else {
            DispatchQueue.main.async {
                self.progressTableView.reloadData()
            }
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
        if isThisWeek {
            cell.monthlyHabit = habit
            return cell
        } else {
            cell.habit = habit
            return cell
        }
        
    }
}

// MARK: - ChartViewDelegate
// For every habit we need to get the completionPercent array create the values
extension HabitProgressDetailViewController: ChartViewDelegate {
    func setChartData(habits: [Habit]) {
        var dataSets = [LineChartDataSet]()
        for habit in habits {
            let reversed = habit.completionPercent.reversed()
            let val = Array(reversed)
            let values = (0..<val.count).map { (i) -> ChartDataEntry in
                return ChartDataEntry(x: Double(i) + 1, y: val[i])
        }
            let set: LineChartDataSet = LineChartDataSet(values: values, label: nil)
            set.axisDependency = .left
            set.setColor(UIColor(named: "\(habit.category)Color") ?? .red, alpha: 0.5)
            set.setCircleColor(UIColor(named: "\(habit.category)Color") ?? .red)
            set.lineWidth = 2.0
            set.circleRadius = 6.0
            set.fillColor = UIColor(named: "\(habit.category)Color") ?? .red
            set.circleHoleColor = UIColor(named: "\(habit.category)Color") ?? .red
            set.drawValuesEnabled = false
            dataSets.append(set)
            let data = LineChartData(dataSets: dataSets)
            self.progressChartView.data = data
        }
    }
}
