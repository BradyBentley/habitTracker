//
//  ProgressTableViewCell.swift
//  HabitTracker
//
//  Created by Karissa McDaris on 1/21/19.
//  Copyright © 2019 HabitGroup. All rights reserved.
//

import UIKit

class ProgressTableViewCell: UITableViewCell {
    // MARK: - IBOutlets
    @IBOutlet weak var categoryColorImageView: UIImageView!
    @IBOutlet weak var categoryIconImageView: UIImageView!
    @IBOutlet weak var habitNameLabel: UILabel!
    
    // MARK: - Properties
    var habit: Habit? {
        didSet{
            updateViews()
        }
    }
    
    // MARK: - Methods
    func updateViews() {
        guard let habit = habit else { return }
        habitNameLabel.text = habit.habitDescription
        categoryIconImageView.image = UIImage(named: "\(habit.category)")
        categoryColorImageView.image = UIImage(named: "\(habit.category)color")
    }
}
