//
//  AddAirlineViewModel.swift
//  Vodafone Airlines
//
//  Created by Hassan Ashraf on 04/10/2021.
//

import Foundation

protocol AddAirlineViewModelProtocol {
  var screenTitle: String { get }
  var state: Bindable<State> { get }
  var airlineName: String? { get set }
  var airlineCountry: String? { get set }
  var airlineSlogan: String? { get set }
  var airlineAddress: String? { get set }
  var airlineWebsite: String? { get set }
  var errorMessage: Bindable<String> { get }
  func didPressSave()
  func didPressCancel()
  func newAirlineAddedSuccessfully()
}

class AddAirlineViewModel: NSObject, AddAirlineViewModelProtocol {

  var screenTitle: String
  var state: Bindable<State>
  var errorMessage: Bindable<String>
  
  //MARK: Airline Details
  var airlineName: String?
  var airlineCountry: String?
  var airlineSlogan: String?
  var airlineAddress: String?
  var airlineWebsite: String?
  
  //MARK: Data Repo
  private var dataRepo: AddAirlineRepositoryProtocol
  
  init(repo: AddAirlineRepositoryProtocol = AddAirlineRepository()) {
    dataRepo = repo
    screenTitle = "Add a New Airline"
    state = Bindable<State>(.empty)
    errorMessage = Bindable<String>("")
  }
  
  func didPressSave() {
    if validate() {
      self.state.value = .loading
      self.addAirline()
    } else {
      self.state.value = .error
    }
  }
  
  func addAirline() {
    
    self.dataRepo.AddAirline(name: airlineName ?? "", slogan: airlineSlogan ?? "", country: airlineCountry ?? "", headquarter: airlineAddress ?? "", website: airlineWebsite ?? "") { [weak self] success, error in
      guard let self = self else { return }
      guard error == nil else {
        self.state.value = .error
        self.errorMessage.value = error
        return
      }
      self.state.value = .populated
    }
  }
  
  func didPressCancel() {
    self.state.value = .cancel
  }
  
  func newAirlineAddedSuccessfully() {
    NotificationCenter.default.post(name: Notification.Name("NewAirlineAdded"), object: nil)
  }
  
  //MARK: Basic Validation.. (For more complicated validation, we could build one using Factory Design Pattern)
  func validate() -> Bool {
    
    guard let name = airlineName, !name.isEmpty, name.count > 2 else {
      self.errorMessage.value = "Please enter a valid name"
      return false
    }
    
    guard let slogan = airlineSlogan, !slogan.isEmpty, slogan.count > 2 else {
      self.errorMessage.value = "Please enter a valid slogan"
      return false
    }
    
    guard let country = airlineCountry, !country.isEmpty, country.count > 2 else {
      self.errorMessage.value = "Please enter a valid country name"
      return false
    }
    
    guard let address = airlineAddress, !address.isEmpty, address.count > 2 else {
      self.errorMessage.value = "Please enter a valid address"
      return false
    }
    
    guard let website = airlineWebsite, !website.isEmpty, website.count > 10 else {
      self.errorMessage.value = "Please enter a valid website"
      return false
    }
    
    return true
    
  }
  
}
