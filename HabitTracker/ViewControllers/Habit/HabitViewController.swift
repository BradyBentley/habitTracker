//
//  HabitViewController.swift
//  HabitTracker
//
//  Created by Brady Bentley on 1/17/19.
//  Copyright © 2019 HabitGroup. All rights reserved.
//

import UIKit

class HabitViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var habitTitleLabel: UILabel!
    @IBOutlet weak var habitdescriptionLabel: UILabel!
    @IBOutlet weak var percentageCompletionLabel: UILabel!
    @IBOutlet weak var markAsDoneButton: UIButton!
    @IBOutlet weak var habitReminderTableView: UITableView!
    
    
    // MARK: - ViewLife Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Actions
    @IBAction func editButtonTapped(_ sender: Any) {
    }
    @IBAction func markAsDoneButtonTapped(_ sender: Any) {
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
}

extension HabitViewController: UITableViewDelegate, UITableViewDataSource{
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
