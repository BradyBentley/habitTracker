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
    
    
    //let trackLayer = CAShapeLayer()
    
    var fullShapeLayer: CAShapeLayer!
    var outerShapeLayer: CAShapeLayer!
    
    let quarterCircle = (CGFloat.pi / 2)
    let fullCircle = (CGFloat.pi * 2)
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var progressView: UIView!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var habitDescriptionLabel: UILabel!
    @IBOutlet weak var successLabel: UILabel!
    @IBOutlet weak var percentageCompletionLabel: UILabel!
    @IBOutlet weak var habitReminderTableView: UITableView!
    @IBOutlet weak var detailProgressChartView: LineChartView!
    
    // MARK: - Properties
    
    var habit: Habit?
    
    let timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        return formatter
    }()
    
    // MARK: - ViewLife Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        habitReminderTableView.dataSource = self
        habitReminderTableView.delegate = self
        habitReminderTableView.tableFooterView = UIView()
        updateViews()
    }
    
    // MARK: - Actions
    
    @IBAction func doneButtonPushed(_ sender: Any) {
       self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Setup
    func updateViews() {
        guard let habit = habit else { return }
        setChartData(completionPercent: habit.completionPercent)
        LineChartController.shared.setup(chartView: detailProgressChartView)
        habitDescriptionLabel.text = habit.habitDescription
        successLabel.text = habit.category.uppercased()
        iconImageView.image = UIImage(named: "\(habit.category)Selected")
        percentageCompletionLabel.text = "\(Int(habit.completion))%"
        setChartData(completionPercent: habit.completionPercent)
        LineChartController.shared.setup(chartView: detailProgressChartView)
        
        fullShapeLayer = animateProgressBar(percentage: 1, strokeEnd: 1, strokeColor: UIColor(named: "\(habit.category)Track")?.cgColor)
        
        outerShapeLayer = animateProgressBar(percentage: CGFloat(habit.completion / 100), strokeEnd: 0, strokeColor: UIColor(named: "\(habit.category)Color")?.cgColor)
        
        animation()
    }
    
    func animateProgressBar(percentage: CGFloat, strokeEnd: CGFloat, strokeColor: CGColor?) -> CAShapeLayer{
        let shapeLayer = CAShapeLayer()
        
        let center = progressView.center
        let circularPathTakeTwo = UIBezierPath(arcCenter: center, radius: 28, startAngle: -quarterCircle, endAngle: ((fullCircle * percentage) - quarterCircle), clockwise: true)
//        trackLayer.path = circularPathTakeTwo.cgPath
//        trackLayer.strokeColor = strokeColor
//        trackLayer.lineWidth = 4
//        trackLayer.lineCap = CAShapeLayerLineCap.round
//        trackLayer.strokeEnd = strokeEnd
//        trackLayer.fillColor = UIColor.clear.cgColor
//
//        progressView.layer.addSublayer(trackLayer)
        
        shapeLayer.path = circularPathTakeTwo.cgPath
        shapeLayer.strokeColor = strokeColor
        shapeLayer.lineWidth = 4
        shapeLayer.lineCap = CAShapeLayerLineCap.round
        shapeLayer.strokeEnd = strokeEnd
        shapeLayer.fillColor = UIColor.clear.cgColor
        
        progressView.layer.addSublayer(shapeLayer)
        
//        UIView.animate(withDuration: 1) {
//            self.animation()
//        }
        return shapeLayer
        
    }
    
    func animation() {
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        
        //basicAnimation.fromValue = 0.0
        basicAnimation.toValue = 1
        basicAnimation.duration = 1
        basicAnimation.fillMode = CAMediaTimingFillMode.forwards
        
        basicAnimation.isRemovedOnCompletion = false
        
        outerShapeLayer.add(basicAnimation, forKey: "basic")
    }

    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToEditHabitDetail" {
            if let destinationVC = segue.destination as? EditHabitViewController {
                if let habit = habit {
                    destinationVC.habit = habit
                }
            }
        }
    }
}

extension HabitDetailViewController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if tableView == habitReminderTableView {
            return 2
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == habitReminderTableView {
            if section == 0 {
                return habit?.timeReminder.count ?? 0
            } else {
                return habit?.locationReminder.count ?? 0
            }
        } else {
            return habit?.daysCompleted.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let habit = habit else { return UITableViewCell() }
        
        if tableView == habitReminderTableView {
            var cell: UITableViewCell
            if indexPath.section == 0 {
                cell = tableView.dequeueReusableCell(withIdentifier: "TimeReminderCell", for: indexPath)
                let timeReminder = habit.timeReminder[indexPath.row]
                let time = timeFormatter.string(from: timeReminder.time)
                var reminder = time + " - "
                let days = timeReminder.day
                for day in days {
                    switch day {
                    case 0:
                        reminder.append("Sun ")
                    case 1:
                        reminder.append("Mon ")
                    case 2:
                        reminder.append("Tue ")
                    case 3:
                        reminder.append("Wed ")
                    case 4:
                        reminder.append("Thu ")
                    case 5:
                        reminder.append("Fri ")
                    default:
                        reminder.append("Sat ")
                    }
                }
                cell.textLabel?.text = timeReminder.reminderText
                cell.detailTextLabel?.text = reminder
            } else {
                cell = tableView.dequeueReusableCell(withIdentifier: "LocationReminderCell", for: indexPath)
                let locationReminder = habit.locationReminder[indexPath.row]
                cell.textLabel?.text = locationReminder.reminderText
                cell.detailTextLabel?.text = locationReminder.locationName
            }
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CheckInCell", for: indexPath)
            return cell
        }
    }
    
}

// MARK: - ChartViewDelegate
extension HabitDetailViewController: ChartViewDelegate {
    func setChartData(completionPercent: [Double]) {
        let values = (0..<completionPercent.count).map { (i) -> ChartDataEntry in
            let reversed = completionPercent.reversed()
            let val = Array(reversed)
            return ChartDataEntry(x: Double(i) + 1, y: val[i])
        }
        let set1: LineChartDataSet = LineChartDataSet(values: values, label: nil)
        guard let habit = habit else { return }
        set1.axisDependency = .left
        set1.setColor(UIColor(named: "\(habit.category)Color") ?? .red, alpha: 0.5)
        set1.setCircleColor(UIColor(named: "\(habit.category)Color") ?? .red)
        set1.lineWidth = 2.0
        set1.circleRadius = 6.0
        set1.fillColor = UIColor(named: "\(habit.category)Color") ?? .red
        set1.circleHoleColor = UIColor(named: "\(habit.category)Color") ?? .red
        set1.drawValuesEnabled = false
        
        let data1 = LineChartData(dataSet: set1)
        self.detailProgressChartView.data = data1
    }
}


