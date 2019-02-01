//
//  NewHabitViewController.swift
//  HabitTracker
//
//  Created by David Truong on 1/22/19.
//  Copyright © 2019 HabitGroup. All rights reserved.
//

import UIKit
import UserNotifications

class NewHabitViewController: UIViewController, UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        dayPickerView.dataSource = self
        dayPickerView.delegate = self
        weekPickerView.dataSource = self
        weekPickerView.delegate = self
        habitNameTextField.delegate = self
        dayPickerView.showsSelectionIndicator = true
        weekPickerView.showsSelectionIndicator = true
        navigationItem.rightBarButtonItem?.title = "Next"
        
        requestUserNotificationPermissions()
    }
    
    // MARK: - Properties
    
    @IBOutlet weak var startHabitButton: UIButton!
    @IBOutlet weak var kickHabitButton: UIButton!
    @IBOutlet weak var financialButton: UIButton!
    @IBOutlet weak var wellnessButton: UIButton!
    @IBOutlet weak var intellectualButton: UIButton!
    @IBOutlet weak var fitnessButton: UIButton!
    @IBOutlet weak var relationshipButton: UIButton!
    @IBOutlet weak var nutritionButton: UIButton!
    @IBOutlet weak var productivityButton: UIButton!
    @IBOutlet weak var mindsetButton: UIButton!
    @IBOutlet weak var otherButton: UIButton!
    
    @IBOutlet weak var habitNameTextField: UITextField!
    @IBOutlet weak var dayPickerView: UIPickerView!
    @IBOutlet weak var weekPickerView: UIPickerView!
    
    var categoryButtons: [UIButton] = []
    var isNewHabit: Bool = true
    var category: String = ""
    var days: Int = 1
    var weeks: Int = 1
    var allowNotifications: Bool?
    
    // MARK: - Button actions
    
    @IBAction func cancelButtonPushed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func startHabitButtonClicked(_ sender: Any) {
        if isNewHabit {
            startHabitButton.setImage(UIImage(named: "unchecked"), for: .normal)
            kickHabitButton.setImage(UIImage(named: "checked"), for: .normal)
            isNewHabit = false
        } else {
            startHabitButton.setImage(UIImage(named: "checked"), for: .normal)
            kickHabitButton.setImage(UIImage(named: "unchecked"), for: .normal)
            isNewHabit = true
        }
    }
    
    @IBAction func kickHabitClicked(_ sender: Any) {
        if isNewHabit {
            startHabitButton.setImage(UIImage(named: "unchecked"), for: .normal)
            kickHabitButton.setImage(UIImage(named: "checked"), for: .normal)
            isNewHabit = false
        } else {
            startHabitButton.setImage(UIImage(named: "checked"), for: .normal)
            kickHabitButton.setImage(UIImage(named: "unchecked"), for: .normal)
            isNewHabit = true
        }
    }
    
    @IBAction func financialButtonClicked(_ sender: Any) {
        if category == "financial" {
            setAllButtonsToUnselected()
            category = ""
        } else {
            setAllButtonsToUnselected()
            financialButton.setImage(UIImage(named: "financialSelected"), for: .normal)
            category = "financial"
        }
    }
    
    @IBAction func fitnessButtonClicked(_ sender: Any) {
        if category == "fitness" {
            setAllButtonsToUnselected()
            category = ""
        } else {
            setAllButtonsToUnselected()
            fitnessButton.setImage(UIImage(named: "fitnessSelected"), for: .normal)
            category = "fitness"
        }
    }
    
    @IBAction func productivityButtonClicked(_ sender: Any) {
        if category == "productivity" {
            setAllButtonsToUnselected()
            category = ""
        } else {
            setAllButtonsToUnselected()
            productivityButton.setImage(UIImage(named: "productivitySelected"), for: .normal)
            category = "productivity"
        }
    }
    
    @IBAction func wellnessButtonClicked(_ sender: Any) {
        if category == "wellness" {
            setAllButtonsToUnselected()
            category = ""
        } else {
            setAllButtonsToUnselected()
            wellnessButton.setImage(UIImage(named: "wellnessSelected"), for: .normal)
            category = "wellness"
        }
    }
    
    @IBAction func relationshipButtonClicked(_ sender: Any) {
        if category == "relationship" {
            setAllButtonsToUnselected()
            category = ""
        } else {
            setAllButtonsToUnselected()
            relationshipButton.setImage(UIImage(named: "relationshipSelected"), for: .normal)
            category = "relationship"
        }
    }
    
    @IBAction func mindsetButtonClicked(_ sender: Any) {
        if category == "mindset" {
            setAllButtonsToUnselected()
            category = ""
        } else {
            setAllButtonsToUnselected()
            mindsetButton.setImage(UIImage(named: "mindsetSelected"), for: .normal)
            category = "mindset"
        }
    }
    
    @IBAction func intellectualButtonClicked(_ sender: Any) {
        if category == "intellectual" {
            setAllButtonsToUnselected()
            category = ""
        } else {
            setAllButtonsToUnselected()
            intellectualButton.setImage(UIImage(named: "intellectualSelected"), for: .normal)
            category = "intellectual"
        }
    }
    
    @IBAction func nutritionButtonClicked(_ sender: Any) {
        if category == "nutrition" {
            setAllButtonsToUnselected()
            category = ""
        } else {
            setAllButtonsToUnselected()
            nutritionButton.setImage(UIImage(named: "nutritionSelected"), for: .normal)
            category = "nutrition"
        }
    }
    
    @IBAction func otherButtonClicked(_ sender: Any) {
        if category == "other" {
            setAllButtonsToUnselected()
            category = ""
        } else {
            setAllButtonsToUnselected()
            otherButton.setImage(UIImage(named: "otherSelected"), for: .normal)
            category = "other"
        }
    }
    
    // MARK: - Helper functions
    
    func setAllButtonsToUnselected() {
        financialButton.setImage(UIImage(named: "financial"), for: .normal)
        wellnessButton.setImage(UIImage(named: "wellness"), for: .normal)
        intellectualButton.setImage(UIImage(named: "intellectual"), for: .normal)
        fitnessButton.setImage(UIImage(named: "fitness"), for: .normal)
        relationshipButton.setImage(UIImage(named: "relationship"), for: .normal)
        nutritionButton.setImage(UIImage(named: "nutrition"), for: .normal)
        productivityButton.setImage(UIImage(named: "productivity"), for: .normal)
        mindsetButton.setImage(UIImage(named: "mindset"), for: .normal)
        otherButton.setImage(UIImage(named: "other"), for: .normal)
    }
    
    // MARK: - User notifications
    
    func requestUserNotificationPermissions() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { (granted, _) in
            self.allowNotifications = granted ? true : false
        }
    }
    
    // MARK: - UITextfield delegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // MARK: - UIPickerView source
    
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
    
    // MARK: - UIPickerView delegate
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == dayPickerView {
            days = row + 1
        } else {
            weeks = row + 1
        }
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? ReminderViewController {
            if segue.identifier == "ToReminderView" {
                if let habitName = habitNameTextField.text, !habitName.isEmpty, !category.isEmpty {
                    let habit = Habit(isNewHabit: isNewHabit, category: category, habitDescription: habitName, days: days, weeks: weeks)
                    destinationVC.habit = habit
                } else {
                    let missingInformationAlert = UIAlertController(title: "Missing Information", message: "Habit name and category required", preferredStyle: .alert)
                    let cancel = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
                    missingInformationAlert.addAction(cancel)
                    self.present(missingInformationAlert, animated: true)
                }
            }
        }
    }

}
