//
//  HabitTableViewCell.swift
//  HabitTracker
//
//  Created by Brady Bentley on 1/17/19.
//  Copyright © 2019 HabitGroup. All rights reserved.
//

import UIKit

class HabitTableViewCell: UITableViewCell {
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var habitDescriptionLabel: UILabel!
    @IBOutlet weak var progressView: UIView!
    @IBOutlet weak var successLabel: UILabel!
    @IBOutlet weak var percentCompletionLabel: UILabel!
    
    // MARK: - Properties
    var habit: Habit?{
        didSet {
            updateViews()
        }
    }
    
    // MARK: - Setup
    func updateViews() {
        guard let habit = habit else { return }
        iconImageView.image = UIImage(named: "\(habit.category)Progress")
        habitDescriptionLabel.text = habit.habitDescription
        successLabel.text = "\(habit.days) days a week for \(habit.weeks) weeks"
        percentCompletionLabel.text = "\(Int(habit.completion))%"
       // animateProgressBar()
    }
    
//    func animateProgressBar(){
//        guard let habit = habit else {return}
//
//        let center = progressBar.center
//        let circularPath = UIBezierPath(arcCenter: center, radius: 28, startAngle: -CGFloat.pi / 2, endAngle: 2 * CGFloat.pi, clockwise: true)
//
//        trackLayer.path = circularPath.cgPath
//        trackLayer.strokeColor = UIColor(named: "\(habit.category)Track")?.cgColor
//        trackLayer.lineWidth = 4
//        trackLayer.lineCap = CAShapeLayerLineCap.round
//        trackLayer.fillColor = UIColor.clear.cgColor
//
//        progressBar.layer.addSublayer(trackLayer)
//
//        shapeLayer.path = circularPath.cgPath
//        shapeLayer.strokeColor = UIColor(named: "\(habit.category)Color")?.cgColor
//        shapeLayer.lineWidth = 4
//        shapeLayer.lineCap = CAShapeLayerLineCap.round
//        shapeLayer.strokeEnd = 0
//        shapeLayer.fillColor = UIColor.clear.cgColor
//
//        progressBar.layer.addSublayer(shapeLayer)
//    }
}
