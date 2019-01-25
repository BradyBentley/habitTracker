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
        // TODO: percentCompletionLabel
    }
}
