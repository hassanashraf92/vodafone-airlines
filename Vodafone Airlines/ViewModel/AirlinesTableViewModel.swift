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
  func addNewAirline()
  func searchAirline(query: String)
  func fetchData()
  
  var airlineCellViewModels: Bindable<[Airline]> { get }
  func getAirline(at indexPath: IndexPath) -> Airline?
}

class AirlinesTableViewModel: NSObject, AirlinesTableViewModelProtocol {
  
  var screenTitle: String = "Countries"
  var state: Bindable<State> = Bindable<State>(.empty)
  
  private var airlines: [Airline] = [Airline]()
  var airlineCellViewModels: Bindable<[Airline]> = Bindable<[Airline]>([])
  
  func addNewAirline() {
    print("Add New Airline Pressed")
  }
  
  func searchAirline(query: String) {
    guard !query.isEmpty else {
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
  
  func fetchData() {
    self.state.value = .loading
    let data = generateMockData()
    DispatchQueue.global().async {
      sleep(3)
      self.airlines = data
      self.airlineCellViewModels.value = data
      self.state.value = .populated
      
      
      CoreDataStorage.shared.clearStorage(forEntity: "Airline")
      CoreDataStorage.shared.saveContext()
      
      let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
      print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@")
      print(paths[0])
      
    }
  }
  
  func generateMockData() -> [Airline] {
    let path = Bundle.main.path(forResource: "airlines", ofType: "json")!
    let data = try! Data(contentsOf: URL(fileURLWithPath: path))
    
    
    let decoder = JSONDecoder()
    let managedObjectContext = CoreDataStorage.shared.managedObjectContext()
    guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.managedObjectContext else {
      fatalError("Failed to retrieve managed object context Key")
    }
    decoder.userInfo[codingUserInfoKeyManagedObjectContext] = managedObjectContext
    
    do {
      let result = try decoder.decode(AirlineResponse.self, from: data)
      print(result.airlines)
      return result.airlines
    } catch let error {
      print("decoding error: \(error)")
      return []
    }

    
  }
}
