//
//  ProgressTableViewCell.swift
//  HabitTracker
//
//  Created by Karissa McDaris on 1/21/19.
//  Copyright © 2019 HabitGroup. All rights reserved.
//

import UIKit

class ProgressTableViewCell: UITableViewCell {
    // MARK: - IBOutlets
    @IBOutlet weak var categoryColorImageView: UIImageView!
    @IBOutlet weak var categoryIconImageView: UIImageView!
    @IBOutlet weak var habitNameLabel: UILabel!
    @IBOutlet weak var oneImageView: UIImageView!
    @IBOutlet weak var twoImageView: UIImageView!
    @IBOutlet weak var threeImageView: UIImageView!
    @IBOutlet weak var fourImageView: UIImageView!
    @IBOutlet weak var fiveImageView: UIImageView!
    @IBOutlet weak var sixImageView: UIImageView!
    @IBOutlet weak var sevenImageView: UIImageView!
    @IBOutlet weak var imagesStackView: UIStackView!
    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var numberOfDaysLabel: UILabel!
    
    // MARK: - Properties
    var habit: Habit? {
        didSet{
            updateViews()
        }
    }
    
    var monthlyHabit: Habit? {
        didSet{
            updateMonthlyViews()
        }
    }
    
    // MARK: - Methods
    func updateViews() {
        guard let habit = habit else { return }
        habitNameLabel.text = habit.habitDescription
        categoryIconImageView.image = UIImage(named: "\(habit.category)")
        numberOfDaysLabel.text = "\(habit.days) days per week"
        numberOfDaysLabel.isHidden = false
        imagesStackView.isHidden = false
        colorView.isHidden = true
        categoryColorImageView.isHidden = true
        let numberOfLabels = habit.days
        switch numberOfLabels {
        case 1:
            oneImageView.isHidden = false
            twoImageView.isHidden = true
            threeImageView.isHidden = true
            fourImageView.isHidden = true
            fiveImageView.isHidden = true
            sixImageView.isHidden = true
            sevenImageView.isHidden = true
        case 2:
            oneImageView.isHidden = false
            twoImageView.isHidden = false
            threeImageView.isHidden = true
            fourImageView.isHidden = true
            fiveImageView.isHidden = true
            sixImageView.isHidden = true
            sevenImageView.isHidden = true
        case 3:
            oneImageView.isHidden = false
            twoImageView.isHidden = false
            threeImageView.isHidden = false
            fourImageView.isHidden = true
            fiveImageView.isHidden = true
            sixImageView.isHidden = true
            sevenImageView.isHidden = true
        case 4:
            oneImageView.isHidden = false
            twoImageView.isHidden = false
            threeImageView.isHidden = false
            fourImageView.isHidden = false
            fiveImageView.isHidden = true
            sixImageView.isHidden = true
            sevenImageView.isHidden = true
        case 5:
            oneImageView.isHidden = false
            twoImageView.isHidden = false
            threeImageView.isHidden = false
            fourImageView.isHidden = false
            fiveImageView.isHidden = false
            sixImageView.isHidden = true
            sevenImageView.isHidden = true
        case 6:
            oneImageView.isHidden = false
            twoImageView.isHidden = false
            threeImageView.isHidden = false
            fourImageView.isHidden = false
            fiveImageView.isHidden = false
            sixImageView.isHidden = false
            sevenImageView.isHidden = true
        case 7:
            oneImageView.isHidden = false
            twoImageView.isHidden = false
            threeImageView.isHidden = false
            fourImageView.isHidden = false
            fiveImageView.isHidden = false
            sixImageView.isHidden = false
            sevenImageView.isHidden = false
        default:
            oneImageView.isHidden = true
            twoImageView.isHidden = true
            threeImageView.isHidden = true
            fourImageView.isHidden = true
            fiveImageView.isHidden = true
            sixImageView.isHidden = true
            sevenImageView.isHidden = true
        }
        numberOfCheckIns()
    }
    
    func updateMonthlyViews(){
        guard let habit = monthlyHabit else { return }
        habitNameLabel.text = habit.habitDescription
        categoryIconImageView.image = UIImage(named: "\(habit.category)")
        categoryColorImageView.image = UIImage(named: "\(habit.category)Checkmark")
        imagesStackView.isHidden = true
        numberOfDaysLabel.isHidden = true
        colorView.isHidden = false
        categoryColorImageView.isHidden = false
    }
    
    func numberOfCheckIns() {
        
        guard let habit = habit else { return }
        let numberOfDaysCheckedIn = habit.daysCheckedIn
        let image = UIImage(named: "\(habit.category)Checkmark")
        switch numberOfDaysCheckedIn {
        case 1:
            oneImageView.image = image
        case 2:
            oneImageView.image = image
            twoImageView.image = image
        case 3:
            oneImageView.image = image
            twoImageView.image = image
            threeImageView.image = image
        case 4:
            oneImageView.image = image
            twoImageView.image = image
            threeImageView.image = image
            fourImageView.image = image
        case 5:
            oneImageView.image = image
            twoImageView.image = image
            threeImageView.image = image
            fourImageView.image = image
            fiveImageView.image = image
        case 6:
            oneImageView.image = image
            twoImageView.image = image
            threeImageView.image = image
            fourImageView.image = image
            fiveImageView.image = image
            sixImageView.image = image
        case 7:
            oneImageView.image = image
            twoImageView.image = image
            threeImageView.image = image
            fourImageView.image = image
            fiveImageView.image = image
            sixImageView.image = image
            sevenImageView.image = image
        default:
            break
            
        }
    }
    
}

extension ProgressTableViewCell {
    enum daysCheckedIn: Int {
        case one = 1, two, three, four, five, six, seven
        
    }
}


