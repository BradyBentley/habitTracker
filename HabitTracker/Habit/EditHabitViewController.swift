//
//  EditHabitViewController.swift
//  HabitTracker
//
//  Created by Brady Bentley on 1/17/19.
//  Copyright © 2019 HabitGroup. All rights reserved.
//

import UIKit

class EditHabitViewController: UIViewController {
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
    @IBOutlet weak var checkInTableView: UITableView!
    
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
    }
    @IBAction func oldHabitButtonTapped(_ sender: Any) {
    }
    @IBAction func saveButtonTapped(_ sender: Any) {
//        guard let habit = habit else { return }
        // TODO: add the update function
    }
}
