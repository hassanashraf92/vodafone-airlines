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
  var airlineCellViewModels: Bindable<[Airline]> { get }
  
  func addNewAirline()
  func searchAirline(query: String)
  func fetchAirlinesData()
  func getAirline(at indexPath: IndexPath) -> Airline?
  var selectedIndex: IndexPath? { get set }
}

class AirlinesTableViewModel: NSObject, AirlinesTableViewModelProtocol {

  
  var screenTitle: String = "Countries"
  var state: Bindable<State> = Bindable<State>(.empty)
  
  private var airlines: [Airline] = [Airline]() //For Caching Purpose..
  var airlineCellViewModels: Bindable<[Airline]> = Bindable<[Airline]>([])
  var selectedIndex: IndexPath?

  private var dataRepo: AirlinesListRepositoryProtocol
  
  init(repo: AirlinesListRepositoryProtocol = AirlinesListRepository()) {
    self.dataRepo = repo
      }
  
  func addNewAirline() {
    print("Add New Airline Pressed")
  }
  
  func searchAirline(query: String) {
    guard !query.isEmpty else {
      airlineCellViewModels.value = airlines
      return
    }
    let filtered = airlines.filter({ airline in
      return airline.name.range(of: query, options: .caseInsensitive, range: nil, locale: nil) != nil
    })
    airlineCellViewModels.value = filtered
  }
  
  func getAirline(at indexPath: IndexPath) -> Airline? {
    return airlineCellViewModels.value?[indexPath.row]
  }
  
  func fetchAirlinesData() {
    
    self.switchViewModelStateTo(.loading)
    
    self.dataRepo.fetchAirlinesData { [weak self] success, airlines, error in
      guard let self = self else { return }
      guard error == nil else {
        self.switchViewModelStateTo(.error)
        return
      }
      
      self.processAirlinesList(airlines)
      self.switchViewModelStateTo(.populated)
    }
  }
  
  
  //MARK: Helper Functions..
  private func switchViewModelStateTo(_ state: State) {
    self.state.value = state
  }
  
  private func processAirlinesList(_ airlines: [Airline]) {
    self.airlines = airlines
    self.airlineCellViewModels.value = airlines
  }
}
