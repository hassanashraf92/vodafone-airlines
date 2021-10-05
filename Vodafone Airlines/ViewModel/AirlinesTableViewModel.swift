//
//  AirlinesTableViewModel.swift
//  Vodafone Airlines
//
//  Created by Hassan Ashraf on 02/10/2021.
//

import Foundation
import UIKit
import CoreData

protocol AirlinesTableViewModelProtocol {
  var screenTitle: String { get }
  var state: Bindable<State> { get }
  var airlineViewModels: Bindable<[Airline]> { get }
  
  func searchAirline(query: String)
  func fetchAirlinesData()
  func getAirline(at indexPath: IndexPath) -> Airline?
  var selectedIndex: IndexPath? { get set }
  var errorMessage: String? { get }
  
  func observeNewAirlineAdd()
}

class AirlinesTableViewModel: NSObject, AirlinesTableViewModelProtocol {
  
  
  var screenTitle: String
  var state: Bindable<State>
  
  private var airlines: [Airline] = [Airline]() //For Caching Purpose..
  var airlineViewModels: Bindable<[Airline]>
  var selectedIndex: IndexPath?
  var errorMessage: String?
  
  private var dataRepo: AirlinesListRepositoryProtocol
  
  init(repo: AirlinesListRepositoryProtocol = AirlinesListRepository()) {
    self.dataRepo = repo
    screenTitle = "Countries"
    state = Bindable<State>(.empty)
    airlineViewModels = Bindable<[Airline]>([])
  }
  
  func searchAirline(query: String) {
    guard !query.isEmpty else {
      airlineViewModels.value = airlines
      return
    }
    let filtered = airlines.filter({ airline in
      return airline.name.range(of: query, options: .caseInsensitive, range: nil, locale: nil) != nil
    })
    airlineViewModels.value = filtered
  }
  
  func getAirline(at indexPath: IndexPath) -> Airline? {
    return airlineViewModels.value?[indexPath.row]
  }
  
  @objc func fetchAirlinesData() {
    
    self.switchViewModelStateTo(.loading)
    
    self.dataRepo.fetchAirlinesData { [weak self] success, airlines, error in
      guard let self = self else { return }
      guard error == nil else {
        self.switchViewModelStateTo(.error)
        self.errorMessage = error
        return
      }
      
      self.processAirlinesList(airlines)
      self.switchViewModelStateTo(.populated)
    }
  }
  
  //TODO: Handle it locally instead for better response
  func observeNewAirlineAdd() {
    NotificationCenter.default.addObserver(self, selector: #selector(fetchAirlinesData), name: Notification.Name("NewAirlineAdded"), object: nil)
  }
  
  
  //MARK: Helper Functions..
  private func switchViewModelStateTo(_ state: State) {
    self.state.value = state
  }
  
  private func processAirlinesList(_ airlines: [Airline]) {
    self.airlines = airlines
    self.airlineViewModels.value = airlines
  }
}
