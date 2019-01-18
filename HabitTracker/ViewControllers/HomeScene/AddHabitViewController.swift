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
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
}

// MARK: - UITableView
extension AddHabitViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // TODO: return number of sections
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        // TODO: put in the habit that we want.
        return cell
    }
    
    
}
