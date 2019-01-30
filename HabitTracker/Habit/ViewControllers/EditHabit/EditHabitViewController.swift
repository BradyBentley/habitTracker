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
    @IBOutlet weak var remindersTableView: UITableView!
    @IBOutlet weak var nameTextField: UITextField!
    
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
        nameTextField.text = habit.habitDescription
        iconImageView.image = UIImage(named: "\(habit.category)Progress")
    }
    
    // MARK: - Action
    @IBAction func deleteButtonTapped(_ sender: Any) {
        guard let habit = habit else {return}
        HabitController.shared.deleteHabit(habit: habit) { (success) in
            if success {
            }
        }
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        
        ///TODO: CHANGE THE UPDATE FUNCTION
        
        
    }
}
