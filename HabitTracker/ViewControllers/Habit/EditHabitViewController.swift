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
    @IBOutlet weak var habitTitleLabel: UILabel!
    @IBOutlet weak var habitDescriptionLabel: UILabel!
    @IBOutlet weak var percentageCompletionLabel: UILabel!
    @IBOutlet weak var newHabitButton: UIButton!
    @IBOutlet weak var oldHabitButton: UIButton!
    @IBOutlet weak var daysAWeekTextField: UITextField!
    @IBOutlet weak var weeksTextField: UITextField!
    @IBOutlet weak var remindersTableView: UITableView!
    @IBOutlet weak var checkInTableView: UITableView!
    
    
    

    // MARK: - ViewLife Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // MARK: - Action
    @IBAction func newHabitButtonTapped(_ sender: Any) {
    }
    @IBAction func oldHabitButtonTapped(_ sender: Any) {
    }
    @IBAction func saveButtonTapped(_ sender: Any) {
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
}
