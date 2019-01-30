//
//  EditHabitViewController.swift
//  HabitTracker
//
//  Created by Karissa McDaris on 1/21/19.
//  Copyright © 2019 HabitGroup. All rights reserved.
//

import UIKit

class EditHabitViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    // MARK: - IBOutlets
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var remindersTableView: UITableView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var dayPickerView: UIPickerView!
    @IBOutlet weak var weekPickerView: UIPickerView!
    
    // MARK: - Properties
    var habit: Habit?
    var days: Int = 1
    var weeks: Int = 1
    
    // MARK: - ViewLife Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        dayPickerView.dataSource = self
        dayPickerView.delegate = self
        weekPickerView.dataSource = self
        weekPickerView.delegate = self
        updateView()
    }
    
    // MARK: - Setup
    func updateView() {
        guard let habit = habit else { return }
        nameTextField.text = habit.habitDescription
        iconImageView.image = UIImage(named: "\(habit.category)Progress")
        days = habit.days
        weeks = habit.weeks
        dayPickerView.selectRow(days - 1, inComponent: 0, animated: true)
        weekPickerView.selectRow(weeks - 1, inComponent: 0, animated: true)
    }
    
    // MARK: - Action
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let habit = habit,
            let habitName = nameTextField.text, !habitName.isEmpty else { return }
        
        HabitController.shared.updateHabit(habit: habit, habitName: habitName, days: days, weeks: weeks) { (_) in
            if let viewControllers: [UIViewController] = self.navigationController?.viewControllers {
                self.navigationController?.popToViewController(viewControllers[viewControllers.count - 3], animated: true)
            }
        }
    }
    
    @IBAction func deleteButtonTapped(_ sender: Any) {
        guard let habit = habit else {return}
        HabitController.shared.deleteHabit(habit: habit) { (success) in
            if success {
            }
        }
    }
    

    // MARK: - UIPickerView Source
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == dayPickerView {
            return 7
        } else {
            return 52
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(row + 1)"
    }
    
    // MARK: - UIPickerView Delegate
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == dayPickerView {
            days = row + 1
        } else {
            weeks = row + 1
        }
    }
    
}
