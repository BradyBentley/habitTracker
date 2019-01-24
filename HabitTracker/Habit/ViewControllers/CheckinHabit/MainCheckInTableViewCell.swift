//
//  MainCheckInTableViewCell.swift
//  HabitTracker
//
//  Created by Karissa McDaris on 1/21/19.
//  Copyright © 2019 HabitGroup. All rights reserved.
//

import UIKit

class MainCheckInTableViewCell: UITableViewCell {

    @IBOutlet weak var categoryIcon: UIImageView!
    
    @IBOutlet weak var habitNameLabel: UILabel!
    
    @IBOutlet weak var habitCheckInButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func habitCheckInButtonTapped(_ sender: Any) {
    }
    
}
