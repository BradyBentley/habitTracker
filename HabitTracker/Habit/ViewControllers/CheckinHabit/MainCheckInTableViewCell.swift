//
//  MainCheckInTableViewCell.swift
//  HabitTracker
//
//  Created by Karissa McDaris on 1/21/19.
//  Copyright © 2019 HabitGroup. All rights reserved.
//

import UIKit

class MainCheckInTableViewCell: UITableViewCell {
    
    var habit: Habit? {
    didSet {
        updateViews()
        }
    }
    
    var wasTapped: Bool = false
    
    @IBOutlet weak var habitNameLabel: UILabel!
    
    @IBOutlet weak var habitCheckInButton: UIButton!
    
    
    
    
    @IBAction func habitCheckInButtonTapped(_ sender: Any) {
        changeCheckBoxImage()
    }
    
    func updateViews() {
        guard let habit = habit else {return}
        self.habitNameLabel.text = habit.habitDescription
        self.habitCheckInButton.setImage(UIImage(named: "unchecked"), for: .normal)
    }
}

extension MainCheckInTableViewCell {
    func changeCheckBoxImage() {
        guard let habit = habit else {return}
        if wasTapped == false {
            habitCheckInButton.setImage(UIImage(named: "\(habit.category)Checkmark"), for: .normal)
            habit.daysCheckedIn += 1
            Firebase.shared.updateDaysCheckedIn(habit: habit, daysCheckedIn: habit.daysCheckedIn) { (_) in
            }
            wasTapped = true
        } else {
            habitCheckInButton.setImage(UIImage(named: "temp"), for: .normal)
            habit.daysCheckedIn -= 1
            Firebase.shared.updateDaysCheckedIn(habit: habit, daysCheckedIn: habit.daysCheckedIn) { (_) in
            }
            wasTapped = false
        }
    }
}
