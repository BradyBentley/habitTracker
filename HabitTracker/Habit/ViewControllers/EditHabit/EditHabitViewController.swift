//
//  EditHabitViewController.swift
//  HabitTracker
//
//  Created by Karissa McDaris on 1/21/19.
//  Copyright © 2019 HabitGroup. All rights reserved.
//

import UIKit

class EditHabitViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var daysAWeekTextField: UITextField!
    @IBOutlet weak var weeksTextField: UITextField!
    @IBOutlet weak var remindersTableView: UITableView!
    @IBOutlet weak var nameTextField: UITextField!
    
    // MARK: - Properties
    var habit: Habit?
    
    // MARK: - ViewLife Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Setup
    func updateView() {
        guard let habit = habit else { return }
//        habitDescriptionLabel.text = habit.habitDescription
//        habitSuccessLabel.text = "\(habit.days) days a week for \(habit.weeks)"
        daysAWeekTextField.text = "\(habit.days)"
        weeksTextField.text = "\(habit.weeks)"
        iconImageView.image = UIImage(named: "\(habit.category)Progress")
    }
    
    // MARK: - Action
    @IBAction func deleteButtonTapped(_ sender: Any) {
        guard let habit = habit else {return}
        HabitController.shared.deleteHabit(habit: habit) { (success) in
            if success {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let habit = habit,
            let name = nameTextField.text,
            let days = daysAWeekTextField.text,
            let daysInt = Int(days),
            let weeks = weeksTextField.text,
            let weeksInt = Int(weeks) else {return}
        HabitController.shared.updateHabit(habit: habit, habitName: name, days: daysInt, weeks: weeksInt) { (success) in
            if success {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
}
