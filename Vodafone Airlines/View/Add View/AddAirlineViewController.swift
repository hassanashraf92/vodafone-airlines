//
//  AddAirlineViewController.swift
//  Vodafone Airlines
//
//  Created by Hassan Ashraf on 04/10/2021.
//

import UIKit

class AddAirlineViewController: BaseViewController {
  
  @IBOutlet weak var activityIndicator: UIActivityIndicatorView! {
    didSet {
      activityIndicator.isHidden = true
      activityIndicator.style = .large
      activityIndicator.color = .primary
    }
  }
  
  @IBOutlet weak var titleLabel: GeneralLabel! {
    didSet {
      titleLabel.size(with: 20)
    }
  }
  @IBOutlet weak var nameTextField: UITextField! {
    didSet {
      nameTextField.placeholder = "Airline name"
    }
  }
  @IBOutlet weak var sloganTextField: UITextField! {
    didSet {
      sloganTextField.placeholder = "Slogan"
    }
  }
  @IBOutlet weak var countryTextField: UITextField! {
    didSet {
      countryTextField.placeholder = "Country"
    }
  }
  @IBOutlet weak var headquartersTextField: UITextField! {
    didSet {
      headquartersTextField.placeholder = "Headquarter"
    }
  }
  @IBOutlet weak var websiteTextField: UITextField! {
    didSet {
      websiteTextField.placeholder = "Website"
    }
  }
  
  @IBOutlet weak var confirmButton: PrimaryButton! {
    didSet {
      confirmButton.setTitle("Confirm", for: .normal)
      let tap = UITapGestureRecognizer(target: self, action: #selector(confirmButtonPressed(_:)))
      confirmButton.addGestureRecognizer(tap)
    }
  }
  
  @IBOutlet weak var cancelButton: UIButton! {
    didSet {
      cancelButton.layer.cornerRadius = 6
      cancelButton.layer.borderWidth = 1
      cancelButton.layer.borderColor = UIColor.border.cgColor
      cancelButton.setTitle("Cancel", for: .normal)
      cancelButton.setTitleColor(.mainText, for: .normal)
      let tap = UITapGestureRecognizer(target: self, action: #selector(cancelButtonPressed(_:)))
      cancelButton.addGestureRecognizer(tap)
    }
  }
  
  var viewModel: AddAirlineViewModel? {
    didSet {
      fillUI()
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    fillUI()
  }
  
  private func fillUI() {
    guard isViewLoaded,
          let viewModel = viewModel else { return }
    
    viewModel.state.bind { [weak self] state in
      guard let self = self else { return }
      switch state {
      case .loading:
        DispatchQueue.main.async {
          self.activityIndicator.startAnimating()
          self.activityIndicator.isHidden = false
          self.view.isUserInteractionEnabled = false
        }
        break
      case .error:
        self.activityIndicator.stopAnimating()
        self.activityIndicator.isHidden = true
        self.view.isUserInteractionEnabled = true
        self.showAlertController(title: "Something went wrong", message: viewModel.errorMessage.value)
        break
      case .cancel:
        self.dismiss(animated: true, completion: nil)
        break
      case .populated:
        DispatchQueue.main.async {
          self.activityIndicator.stopAnimating()
          self.activityIndicator.isHidden = true
          self.view.isUserInteractionEnabled = true
          self.showAlertController(title: "Success", message: "Airline Added Successfully..") {
            self.dismiss(animated: true, completion: nil)
            self.viewModel?.newAirlineAddedSuccessfully()
          }
        }
        break
      default: break
      }
    }
    
    viewModel.errorMessage.bind { message in
      self.showAlertController(message: message)
    }
    
  }
  
  
  
  @objc private func confirmButtonPressed(_ sender: PrimaryButton) {
    viewModel?.airlineName = nameTextField.text
    viewModel?.airlineCountry = countryTextField.text
    viewModel?.airlineSlogan = sloganTextField.text
    viewModel?.airlineAddress = headquartersTextField.text
    viewModel?.airlineWebsite = websiteTextField.text
    viewModel?.didPressSave()
  }
  
  @objc private func cancelButtonPressed(_ sender: UIButton) {
    viewModel?.didPressCancel()
  }
  
  
  
}
