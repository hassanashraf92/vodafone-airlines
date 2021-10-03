//
//  RoundedShadowView.swift
//  Vodafone Airlines
//
//  Created by Hassan Ashraf on 02/10/2021.
//

import UIKit

class CircleShadowView: UIView {
  
  override func awakeFromNib() {
    super.awakeFromNib()
    setupView()
  }
  
  func setupView() {
    self.layer.shadowOpacity = 1
    self.layer.shadowColor = UIColor.primaryShadow.cgColor
    self.layer.shadowRadius = 10
    self.layer.shadowOffset = CGSize(width: 0, height: 0)
    self.layer.cornerRadius = self.frame.height / 2
  }
}
