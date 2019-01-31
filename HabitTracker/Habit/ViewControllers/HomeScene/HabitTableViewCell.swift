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
    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//
//    }
    
    
    // MARK: - Setup
    func updateViews() {
        guard let habit = habit else { return }
        iconImageView.image = UIImage(named: "\(habit.category)Selected")
        habitDescriptionLabel.text = habit.habitDescription
        successLabel.text = "\(habit.days) days a week for \(habit.weeks) weeks"
        percentCompletionLabel.text = "\(Int(habit.completion))%"
        
        fullShapeLayer = animateProgressBar(percentage: 1, strokeEnd: 1, strokeColor: UIColor(named: "\(habit.category)Track")?.cgColor)
        
        outerShapeLayer = animateProgressBar(percentage: CGFloat(habit.completion / 100), strokeEnd: 0, strokeColor: UIColor(named: "\(habit.category)Color")?.cgColor)
    }
    
    func animateProgressBar(percentage: CGFloat, strokeEnd: CGFloat, strokeColor: CGColor?) -> CAShapeLayer{
        
        
            let center = progressView.center

//            fullShapeLayer = setUpShapeLayerFor(percentage: 1, strokeEnd: 1, strokeColor: UIColor(named: "\(habit.category)Track")?.cgColor)
//            outerShapeLayer = setUpShapeLayerFor(percentage: CGFloat((habit.completion) / 100), strokeEnd: 0, strokeColor: UIColor(named: "\(habit.category)Color")?.cgColor)
        
            
            let circularPathTakeTwo = UIBezierPath(arcCenter: center, radius: 28, startAngle: -quarterCircle, endAngle: ((fullCircle * percentage) - quarterCircle), clockwise: true)
            
            //let circularPath = UIBezierPath(arcCenter: center, radius: 28, startAngle: -CGFloat.pi / 2, endAngle: 2 * CGFloat.pi, clockwise: true)
            //let center = UIBezierPath(arcCenter: center, radius: 28, startAngle: (0.6 * CGFloat.pi * 2), endAngle: <#T##CGFloat#>, clockwise: false)
            
            trackLayer.path = circularPathTakeTwo.cgPath
            trackLayer.strokeColor = strokeColor
            trackLayer.lineWidth = 4
            trackLayer.lineCap = CAShapeLayerLineCap.round
            trackLayer.strokeEnd = strokeEnd
            trackLayer.fillColor = UIColor.clear.cgColor
            
            progressView.layer.addSublayer(trackLayer)
            
            shapeLayer.path = circularPathTakeTwo.cgPath
            shapeLayer.strokeColor = strokeColor//UIColor(named: "\(habit.category)Color")?.cgColor
            shapeLayer.lineWidth = 4
            shapeLayer.lineCap = CAShapeLayerLineCap.round
            shapeLayer.strokeEnd = strokeEnd
            shapeLayer.fillColor = UIColor.clear.cgColor
            
            progressView.layer.addSublayer(shapeLayer)
            
            UIView.animate(withDuration: 1) {
                self.animation()
            }
            
            return shapeLayer
        }
    
    func animation() {
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        
        //basicAnimation.fromValue = 0.0
        basicAnimation.toValue = 1
        basicAnimation.duration = 1
        basicAnimation.fillMode = CAMediaTimingFillMode.forwards
        
        basicAnimation.isRemovedOnCompletion = false
        
        shapeLayer.add(basicAnimation, forKey: "basic")
    }
}
