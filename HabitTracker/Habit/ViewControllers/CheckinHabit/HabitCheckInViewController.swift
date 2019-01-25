//
//  HabitCheckInViewController.swift
//  HabitTracker
//
//  Created by Karissa McDaris on 1/20/19.
//  Copyright © 2019 HabitGroup. All rights reserved.
//

import UIKit

class HabitCheckInViewController: UIViewController {
    
    var habit: Habit?

    @IBOutlet weak var CheckInTableView: UITableView!
    
    @IBOutlet weak var topPartOfView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func doneButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension HabitCheckInViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell!
        
        if tableView == CheckInTableView {
            cell = tableView.dequeueReusableCell(withIdentifier: "checkInCell", for: indexPath) as? CheckInCustomTableViewCell
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var count = 0
        
        if tableView == CheckInTableView {
            count = HabitController.shared.habits.count
        }
        return count
    }
    
}
