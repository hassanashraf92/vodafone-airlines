//
//  PrimaryButton.swift
//  Vodafone Airlines
//
//  Created by Hassan Ashraf on 04/10/2021.
//

import UIKit

class PrimaryButton: UIButton {
  
  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)!
    self.commonInit()
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.commonInit()
  }
  
  func commonInit() {
    changeFontFamily()
    self.layer.cornerRadius = 5
    self.setTitleColor(.white, for: .normal)
    self.backgroundColor = UIColor.primary
  }
  
  func changeFontFamily() {
    self.titleLabel?.font = UIFont.init(name: AppFontFamily.regular, size: 18)
  }
  
}
