//
//  ProgressTableViewCell.swift
//  HabitTracker
//
//  Created by Karissa McDaris on 1/21/19.
//  Copyright © 2019 HabitGroup. All rights reserved.
//

import UIKit

class ProgressTableViewCell: UITableViewCell {
    
    @IBOutlet weak var progressButton: UIButton!

    @IBOutlet weak var categoryIcon: UIImageView!
    
    @IBOutlet weak var habitNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func progressButtonTapped(_ sender: Any) {
    }
    
}
