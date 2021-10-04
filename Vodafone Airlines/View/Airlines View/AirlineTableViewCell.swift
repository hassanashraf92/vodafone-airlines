//
//  AirlineTableViewCell.swift
//  Vodafone Airlines
//
//  Created by Hassan Ashraf on 04/10/2021.
//

import UIKit

class AirlineTableViewCell: UITableViewCell {
  
  
  @IBOutlet weak var containerView: RoundShadowView!
  @IBOutlet weak var nameLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  func configure(_ airline: Airline) {
    self.nameLabel.text = airline.name
  }
  
  
}
