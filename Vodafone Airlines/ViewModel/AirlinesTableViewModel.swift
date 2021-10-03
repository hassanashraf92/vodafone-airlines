//
//  AirlinesTableViewModel.swift
//  Vodafone Airlines
//
//  Created by Hassan Ashraf on 02/10/2021.
//

import Foundation

protocol AirlinesTableViewModelProtocol {
  var screenTitle: String { get }
  var state: Bindable<State> { get }
  func addNewAirline()
  func searchAirline(query: String)
  func fetchData()
  
  var airlineCellViewModels: Bindable<[String]> { get }
  func getAirline(at indexPath: IndexPath) -> String
}

class AirlinesTableViewModel: NSObject, AirlinesTableViewModelProtocol {
  
  var screenTitle: String = "Countries"
  var state: Bindable<State> = Bindable<State>(.empty)
  
  private var airlines: [String] = [String]()
  var airlineCellViewModels: Bindable<[String]> = Bindable<[String]>([])
  
  func addNewAirline() {
    print("Add New Airline Pressed")
  }
  
  func searchAirline(query: String) {
    guard !query.isEmpty else {
      return
    }
    let filtered = airlines.filter({ airline in
      return airline.range(of: query, options: .caseInsensitive, range: nil, locale: nil) != nil
    })
    airlineCellViewModels.value = filtered
  }
  
  func getAirline(at indexPath: IndexPath) -> String {
    return airlineCellViewModels.value?[indexPath.row] ?? ""
  }
  
  func fetchData() {
    self.state.value = .loading
    let data = generateMockData()
    DispatchQueue.global().async {
      sleep(3)
      self.airlines = data
      self.airlineCellViewModels.value = data
      self.state.value = .populated
    }
  }
  
  func generateMockData() -> [String] {
    var data = [String]()
    for i in 0...20 {
      data.append("Airline \(i)")
    }
    
    return data
    
  }
  
  
}
