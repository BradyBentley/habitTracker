//
//  CheckInTableViewCell.swift
//  HabitTracker
//
//  Created by Karissa McDaris on 1/21/19.
//  Copyright © 2019 HabitGroup. All rights reserved.
//

import UIKit

class CheckInTableViewCell: UITableViewCell {
    
    @IBOutlet weak var checkInButton: UIButton!
    
    @IBOutlet weak var dateAndTimeOfCheckIn: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func checkInButtonTapped(_ sender: Any) {
    }
    
}
