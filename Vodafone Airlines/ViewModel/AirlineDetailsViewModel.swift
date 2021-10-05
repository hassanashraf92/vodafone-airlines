//
//  AirlineDetailsViewModel.swift
//  Vodafone Airlines
//
//  Created by Hassan Ashraf on 04/10/2021.
//

import Foundation
import UIKit

protocol AirlineDetailsViewModelProtocol {
  var screenTitle: String { get }
  var state: Bindable<State> { get }
  var airline: AirlineViewModel { get }
  var shouldOpenWebsite: Bindable<Bool>? { get }
  func fetchData()
  func didPressVisit()
}

class AirlineDetailsViewModel: NSObject, AirlineDetailsViewModelProtocol {
  
  var screenTitle: String
  var state: Bindable<State> = Bindable<State>(.empty)
  var airline: AirlineViewModel
  var shouldOpenWebsite: Bindable<Bool>? = Bindable<Bool>(false)
  
  init(_ airline: AirlineViewModel) {
    self.screenTitle = "Countries"
    self.airline = airline
  }
  
  func fetchData() {
    self.state.value = .populated
  }
  
  func didPressVisit() {
    guard let website = airline.website, !website.isEmpty else { return }
    self.airline.website = "https://\(website)"
    self.shouldOpenWebsite?.value = true
  }
  
}
