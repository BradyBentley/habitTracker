//
//  MainCheckInTableViewCell.swift
//  HabitTracker
//
//  Created by Karissa McDaris on 1/21/19.
//  Copyright © 2019 HabitGroup. All rights reserved.
//

import UIKit

class MainCheckInTableViewCell: UITableViewCell {

    // MARK: - IBOutlets
    @IBOutlet weak var habitNameLabel: UILabel!
    @IBOutlet weak var habitCheckInButton: UIButton!
    
    // MARK: - Properties
    var wasTapped: Bool?
    var habit: Habit? {
    didSet {
        updateViews()
        }
    }
    
    // MARK: - Actions
    @IBAction func habitCheckInButtonTapped(_ sender: Any) {
        changeCheckBoxImage()
    }
    
    // MARK: - Methods
    func updateViews() {
        guard let habit = habit else {return}
        self.habitNameLabel.text = habit.habitDescription
        if habit.daysCompleted.contains(Date().dateWithoutTime) {
            self.habitCheckInButton.setImage(UIImage(named: "\(habit.category)Checkmark"), for: .normal)
            wasTapped = false
        } else {
            self.habitCheckInButton.setImage(UIImage(named: "unchecked"), for: .normal)
            wasTapped = true
        }
    }
}

extension MainCheckInTableViewCell {
    func changeCheckBoxImage() {
        guard let habit = habit, var wasTapped = wasTapped else { return }
        wasTapped = !wasTapped
        if wasTapped == false {
            habitCheckInButton.setImage(UIImage(named: "\(habit.category)Checkmark"), for: .normal)
            if habit.daysCheckedIn < habit.days{
                habit.daysCheckedIn += 1
                let percent = habit.completion
                habit.completionPercent.removeLast()
                habit.completionPercent.append(percent)
                Firebase.shared.updateDaysCheckedIn(habit: habit, daysCheckedIn: habit.daysCheckedIn) { (success) in
                    habit.daysCompleted.append(Date().dateWithoutTime)
                    Firebase.shared.updateDaysComplete(habit: habit, completion: { (_) in
                    })
                }
                
            }
        } else {
            habitCheckInButton.setImage(UIImage(named: "unchecked"), for: .normal)
            if habit.daysCheckedIn > 0 {
                habit.daysCheckedIn -= 1
                let percent = habit.completion
                habit.completionPercent.removeLast()
                habit.completionPercent.append(percent)
                Firebase.shared.updateDaysCheckedIn(habit: habit, daysCheckedIn: habit.daysCheckedIn) { (success) in
                    habit.daysCompleted.removeLast()
                    Firebase.shared.removeDaysComplete(habit: habit, completion: { (_) in
                    })
                }
            }
        }
    }
}
