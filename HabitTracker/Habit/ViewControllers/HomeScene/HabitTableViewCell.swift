//
//  HabitTableViewCell.swift
//  HabitTracker
//
//  Created by Brady Bentley on 1/17/19.
//  Copyright © 2019 HabitGroup. All rights reserved.
//

import UIKit

class HabitTableViewCell: UITableViewCell {
    
    let shapeLayer = CAShapeLayer()
    let trackLayer = CAShapeLayer()
    
    var fullShapeLayer: CAShapeLayer!
    var outerShapeLayer: CAShapeLayer!
    
    let quarterCircle = (CGFloat.pi / 2)
    let fullCircle = (CGFloat.pi * 2)
    
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
        
        iconImageView.image = UIImage(named: "\(habit.category)Selected")
        habitDescriptionLabel.text = habit.habitDescription
        successLabel.text = "\(habit.days) days a week for \(habit.weeks) weeks"
        percentCompletionLabel.text = "\(Int(habit.completion))%"
        
        self.fullShapeLayer = self.animateProgressBar(percentage: 1, strokeEnd: 1, strokeColor: UIColor(named: "\(habit.category)Track")?.cgColor)
        
        self.outerShapeLayer = self.animateProgressBar(percentage: CGFloat(habit.completion / 100), strokeEnd: 0, strokeColor: UIColor(named: "\(habit.category)Color")?.cgColor)
        self.animation()
    }
    
    func animateProgressBar(percentage: CGFloat, strokeEnd: CGFloat, strokeColor: CGColor?) -> CAShapeLayer{
        
        let shapeLayer = CAShapeLayer()
        
            let center = CGPoint(x: progressView.center.x, y: progressView.center.y - 37)
        
            let circularPathTakeTwo = UIBezierPath(arcCenter: center, radius: 28, startAngle: -quarterCircle, endAngle: ((fullCircle * percentage) - quarterCircle), clockwise: true)
            
            shapeLayer.path = circularPathTakeTwo.cgPath
            shapeLayer.strokeColor = strokeColor
            shapeLayer.lineWidth = 4
            shapeLayer.lineCap = CAShapeLayerLineCap.round
            shapeLayer.strokeEnd = strokeEnd
            shapeLayer.fillColor = UIColor.clear.cgColor
            
            progressView.layer.addSublayer(shapeLayer)
            
            return shapeLayer
        }
    
    func animation() {
        
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        
        basicAnimation.toValue = 1
        basicAnimation.duration = 1
        basicAnimation.fillMode = CAMediaTimingFillMode.forwards
        basicAnimation.isRemovedOnCompletion = false
        
        outerShapeLayer.add(basicAnimation, forKey: "basic")
    }
}
