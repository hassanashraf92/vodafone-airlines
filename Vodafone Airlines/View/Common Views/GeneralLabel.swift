//
//  GeneralLabel.swift
//  Vodafone Airlines
//
//  Created by Hassan Ashraf on 04/10/2021.
//

import UIKit.UILabel

class GeneralLabel: UILabel {
  
  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)!
    self.commonInit()
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.commonInit()
  }
  
  func commonInit() {
    changeFontName()
  }
  
  private func changeFontName() {
    self.textColor = .mainText
    self.font = UIFont(name: AppFontFamily.regular, size: 16)
  }
  
  func size(with size: CGFloat) {
    self.font = UIFont(name: AppFontFamily.regular, size: size)
  }
  
  @objc func bold(with size: CGFloat = 16) {
    self.font = UIFont(name: AppFontFamily.bold, size: size)
  }
  
  @objc func light(with size: CGFloat = 16) {
    self.font = UIFont(name: AppFontFamily.light, size: size)
  }
  
  
  
}

