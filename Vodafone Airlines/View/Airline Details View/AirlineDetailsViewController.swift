//
//  AirlineDetailsViewController.swift
//  Vodafone Airlines
//
//  Created by Hassan Ashraf on 04/10/2021.
//

import UIKit

class AirlineDetailsViewController: BaseViewController {
  
  @IBOutlet weak var nameLabel: GeneralLabel! {
    didSet {
      nameLabel.size(with: 20)
    }
  }
  @IBOutlet weak var countryLabel: GeneralLabel! {
    didSet {
      countryLabel.light(with: 20)
    }
  }
  @IBOutlet weak var sloganLabel: GeneralLabel! {
    didSet {
      sloganLabel.light(with: 16)
    }
  }
  @IBOutlet weak var headQuarterTitleLabel: GeneralLabel! {
    didSet {
      headQuarterTitleLabel.text = "Headquarters"
      headQuarterTitleLabel.bold(with: 14)
    }
  }
  @IBOutlet weak var addressLabel: GeneralLabel! {
    didSet {
      addressLabel.light(with: 16)
    }
  }
  @IBOutlet weak var visitButton: PrimaryButton! {
    didSet {
      let tapGesture = UITapGestureRecognizer(target: self, action: #selector(visitButtonPressed(_:)))
      visitButton.addGestureRecognizer(tapGesture)
    }
  }
  
  var viewModel: AirlineDetailsViewModel? {
    didSet {
      fillUI()
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    fillUI()
  }
  
  fileprivate func fillUI() {
    guard isViewLoaded,
          let viewModel = viewModel else { return }
    
    self.navigationItem.title = viewModel.screenTitle
    
    viewModel.state.bind(observer: { [weak self] state in
      guard let self = self else { return }
      switch state {
      case .populated:
        self.fillData()
      default: break
      }
    })
    
    viewModel.shouldOpenWebsite?.bind(observer: { [weak self] _ in
      print(viewModel.airline.website, "----->")
      if let website = viewModel.airline.website, let url = URL(string: website) {
        UIApplication.shared.open(url)
      }
    })
    
    viewModel.fetchData()
    
  }
  
  private func fillData() {
    self.nameLabel.text = viewModel?.airline.name
    self.countryLabel.text = viewModel?.airline.country
    self.sloganLabel.text = viewModel?.airline.slogan
    self.addressLabel.text = viewModel?.airline.address
  }
  
  @objc private func visitButtonPressed(_ sender: UITapGestureRecognizer) {
    viewModel?.didPressVisit()
  }
}
