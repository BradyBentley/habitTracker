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
    @IBOutlet weak var threeImageVIew: UIImageView!
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
            threeImageVIew.isHidden = true
            fourImageView.isHidden = true
            fiveImageView.isHidden = true
            sixImageView.isHidden = true
            sevenImageView.isHidden = true
        case 2:
            oneImageView.isHidden = false
            twoImageView.isHidden = false
            threeImageVIew.isHidden = true
            fourImageView.isHidden = true
            fiveImageView.isHidden = true
            sixImageView.isHidden = true
            sevenImageView.isHidden = true
        case 3:
            oneImageView.isHidden = false
            twoImageView.isHidden = false
            threeImageVIew.isHidden = false
            fourImageView.isHidden = true
            fiveImageView.isHidden = true
            sixImageView.isHidden = true
            sevenImageView.isHidden = true
        case 4:
            oneImageView.isHidden = false
            twoImageView.isHidden = false
            threeImageVIew.isHidden = false
            fourImageView.isHidden = false
            fiveImageView.isHidden = true
            sixImageView.isHidden = true
            sevenImageView.isHidden = true
        case 5:
            oneImageView.isHidden = false
            twoImageView.isHidden = false
            threeImageVIew.isHidden = false
            fourImageView.isHidden = false
            fiveImageView.isHidden = false
            sixImageView.isHidden = true
            sevenImageView.isHidden = true
        case 6:
            oneImageView.isHidden = false
            twoImageView.isHidden = false
            threeImageVIew.isHidden = false
            fourImageView.isHidden = false
            fiveImageView.isHidden = false
            sixImageView.isHidden = false
            sevenImageView.isHidden = true
        case 7:
            oneImageView.isHidden = false
            twoImageView.isHidden = false
            threeImageVIew.isHidden = false
            fourImageView.isHidden = false
            fiveImageView.isHidden = false
            sixImageView.isHidden = false
            sevenImageView.isHidden = false
        default:
            oneImageView.isHidden = true
            twoImageView.isHidden = true
            threeImageVIew.isHidden = true
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
        switch numberOfDaysCheckedIn {
        case 1:
            oneImageView.image = UIImage(named: "\(habit.category)CheckMark")
        case 2:
            oneImageView.image = UIImage(named: "\(habit.category)CheckMark")
            twoImageView.image = UIImage(named: "\(habit.category)CheckMark")
        case 3:
            oneImageView.image = UIImage(named: "\(habit.category)CheckMark")
            twoImageView.image = UIImage(named: "\(habit.category)CheckMark")
            threeImageVIew.image = UIImage(named: "\(habit.category)CheckMark")
        case 4:
            oneImageView.image = UIImage(named: "\(habit.category)CheckMark")
            twoImageView.image = UIImage(named: "\(habit.category)CheckMark")
            threeImageVIew.image = UIImage(named: "\(habit.category)CheckMark")
            fourImageView.image = UIImage(named: "\(habit.category)CheckMark")
        case 5:
            oneImageView.image = UIImage(named: "\(habit.category)CheckMark")
            twoImageView.image = UIImage(named: "\(habit.category)CheckMark")
            threeImageVIew.image = UIImage(named: "\(habit.category)CheckMark")
            fourImageView.image = UIImage(named: "\(habit.category)CheckMark")
            fiveImageView.image = UIImage(named: "\(habit.category)CheckMark")
        case 6:
            oneImageView.image = UIImage(named: "\(habit.category)CheckMark")
            twoImageView.image = UIImage(named: "\(habit.category)CheckMark")
            threeImageVIew.image = UIImage(named: "\(habit.category)CheckMark")
            fourImageView.image = UIImage(named: "\(habit.category)CheckMark")
            fiveImageView.image = UIImage(named: "\(habit.category)CheckMark")
            sixImageView.image = UIImage(named: "\(habit.category)CheckMark")
        case 7:
            oneImageView.image = UIImage(named: "\(habit.category)CheckMark")
            twoImageView.image = UIImage(named: "\(habit.category)CheckMark")
            threeImageVIew.image = UIImage(named: "\(habit.category)CheckMark")
            fourImageView.image = UIImage(named: "\(habit.category)CheckMark")
            fiveImageView.image = UIImage(named: "\(habit.category)CheckMark")
            sixImageView.image = UIImage(named: "\(habit.category)CheckMark")
            sevenImageView.image = UIImage(named: "\(habit.category)CheckMark")
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


