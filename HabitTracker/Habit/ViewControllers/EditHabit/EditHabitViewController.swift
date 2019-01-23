//
//  EditHabitViewController.swift
//  HabitTracker
//
//  Created by Karissa McDaris on 1/21/19.
//  Copyright © 2019 HabitGroup. All rights reserved.
//

import UIKit

class EditHabitViewController: UIViewController {
    
    var wasTapped: Bool = true
    // MARK: - IBOutlets
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var habitDescriptionLabel: UILabel!
    @IBOutlet weak var habitSuccessLabel: UILabel!
    @IBOutlet weak var percentageCompletionLabel: UILabel!
    @IBOutlet weak var newHabitButton: UIButton!
    @IBOutlet weak var oldHabitButton: UIButton!
    @IBOutlet weak var daysAWeekTextField: UITextField!
    @IBOutlet weak var weeksTextField: UITextField!
    @IBOutlet weak var remindersTableView: UITableView!

    // MARK: - Properties
    var habit: Habit?
    
    // MARK: - ViewLife Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
    }
    
    // MARK: - Setup
    func updateView() {
        guard let habit = habit else { return }
        habitDescriptionLabel.text = habit.habitDescription
        habitSuccessLabel.text = "\(habit.days) days a week for \(habit.weeks)"
        daysAWeekTextField.text = "\(habit.days)"
        weeksTextField.text = "\(habit.weeks)"
    }
    
    // MARK: - Action
    @IBAction func newHabitButtonTapped(_ sender: Any) {
        changeCheckBoxImage()
    }
    @IBAction func oldHabitButtonTapped(_ sender: Any) {
        changeCheckBoxImage()
    }
    @IBAction func saveButtonTapped(_ sender: Any) {
        //        guard let habit = habit else { return }
        // TODO: add the update function
    }
}

extension EditHabitViewController {
    func changeCheckBoxImage() {
        if wasTapped == false {
            oldHabitButton.setImage(#imageLiteral(resourceName: "Filled"), for: .normal)
            newHabitButton.setImage(#imageLiteral(resourceName: "temp"), for: .normal)
            wasTapped = true
        } else {
            oldHabitButton.setImage(#imageLiteral(resourceName: "temp"), for: .normal)
            newHabitButton.setImage(#imageLiteral(resourceName: "Filled"), for: .normal)
            wasTapped = false
        }
    }
    
//    func changeNewHabitCheckBoxImage() {
//        if wasTapped == false {
//            newHabitButton.setImage(#imageLiteral(resourceName: "Filled"), for: .normal)
//            wasTapped = true
//        } else {
//            newHabitButton.setImage(#imageLiteral(resourceName: "temp"), for: .normal)
//            wasTapped = false
//        }
//    }
}
