//
//  HabitViewController.swift
//  HabitTracker
//
//  Created by Brady Bentley on 1/17/19.
//  Copyright © 2019 HabitGroup. All rights reserved.
//

import UIKit

class HabitDetailViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var habitDescriptionLabel: UILabel!
    @IBOutlet weak var successLabel: UILabel!
    @IBOutlet weak var percentageCompletionLabel: UILabel!
    @IBOutlet weak var markAsDoneButton: UIButton!
    @IBOutlet weak var habitReminderTableView: UITableView!
    
    // MARK: - Properties
    var habit: Habit?
    
    // MARK: - ViewLife Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    // MARK: - Actions
    @IBAction func markAsDoneButtonTapped(_ sender: Any) {
    }
    
    // MARK: - Setup
    func updateViews(){
        guard let habit = habit else { return }
        habitDescriptionLabel.text = habit.habitDescription
        successLabel.text = "\(habit.days) days a week for \(habit.weeks)"
        // TODO: percentage complete label & complete the mark as done.
        
    }
    
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToEditHabitDetail" {
            let destinationVC = segue.destination as? EditHabitViewController
            destinationVC?.habit = habit
        }
    }
}

extension HabitDetailViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // TODO: number of rows for reminders
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "toBeName", for: indexPath)
        // TODO: what needs to be in the cell
        return cell
    }
}
