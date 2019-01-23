//
//  CheckInCustomTableViewCell.swift
//  HabitTracker
//
//  Created by Karissa McDaris on 1/22/19.
//  Copyright © 2019 HabitGroup. All rights reserved.
//

import UIKit

class CheckInCustomTableViewCell: UITableViewCell {
    
    var check: Habit?
    
    @IBOutlet weak var checkButton: UIButton!
    
    @IBOutlet weak var dateAndTimeOfCheckIn: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func checkButtonTapped(_ sender: Any) {
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateViews() {
        //guard let check = check else {return}
        //dateAndTimeOfCheckIn.text = "\(Date)"
        
    }

}
