//
//  AddHabitViewController.swift
//  HabitTracker
//
//  Created by Brady Bentley on 1/17/19.
//  Copyright © 2019 HabitGroup. All rights reserved.
//

import UIKit

class AddHabitViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var habitsTableView: UITableView!
    
    // MARK: - Properties
    
    // MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        habitsTableView.delegate = self
        habitsTableView.dataSource = self
        Firebase.shared.fetchHabits { (success) in
            if success {
                self.habitsTableView.reloadData()
            }
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToHabitDetail" {
            guard let indexPath = habitsTableView.indexPathForSelectedRow else { return }
            let destinationVC = segue.destination as? HabitDetailViewController
            let habit = HabitController.shared.habits[indexPath.row]
            destinationVC?.habit = habit
        }
    }
}

// MARK: - UITableView
extension AddHabitViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return HabitController.shared.habits.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HabitCell", for: indexPath) as! HabitTableViewCell
        let habit = HabitController.shared.habits[indexPath.row]
        cell.habit = habit
        return cell
    }
    
    
}
