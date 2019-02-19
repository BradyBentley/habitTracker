//
//  CustomLabel.swift
//  HabitTracker
//
//  Created by DevMountain on 2/19/19.
//  Copyright © 2019 HabitGroup. All rights reserved.
//

import UIKit

class CustomLabel: UILabel {
    
    override func awakeFromNib() {
      super.awakeFromNib()
      self.updateFontTo(fontName: "SFProText-Medium")
      self.textColor = .habitDarkGray
    }
    
    func updateFontTo(fontName: String){
      let size = self.font.pointSize
      self.font = UIFont(name: fontName, size: size)!
    }
}
