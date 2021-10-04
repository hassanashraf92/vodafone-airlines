//
//  AddAirlineRemoteRepository.swift
//  Vodafone Airlines
//
//  Created by Hassan Ashraf on 05/10/2021.
//

import Foundation

class AddAirlineRemoteRepository {
  
  func addAirline(name: String, slogan: String, country: String, Headquarter: String, website: String, complete: @escaping (Bool, String?) -> ()) {
    let parameters: [String: Any] = [:]
    APIManager.shared().request(type: EndPointItem.addNewAirline, params: parameters) { (airline: AirlineResponse?, error: String?) in
      guard error == nil else {
        complete(false, error)
        return
      }
      guard let _ = airline else { return }
      complete(true, nil)
    }
  }
  
  func fetchAirlinesData(complete: @escaping (Bool, Airlines, String?) -> ()) {
    APIManager.shared().request(type: EndPointItem.getAirlinesList) { (airlines: Airlines?, error: String?) in
      guard error == nil else {
        complete(false, [], error)
        return
      }
      guard let airlines = airlines else { return }
      complete(true, airlines, nil)
    }
    
  }
}
