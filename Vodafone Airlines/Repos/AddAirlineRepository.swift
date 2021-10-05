//
//  AddAirlineRepository.swift
//  Vodafone Airlines
//
//  Created by Hassan Ashraf on 05/10/2021.
//

import Foundation

protocol AddAirlineRepositoryProtocol {
  func AddAirline(airline: AirlineViewModel, complete: @escaping ( _ success: Bool, _ error: String? )->() )
}

class AddAirlineRepository {
  
  private let apiService: AddAirlineRemoteRepository
  
  init() {
    self.apiService = AddAirlineRemoteRepository()
  }
}

extension AddAirlineRepository: AddAirlineRepositoryProtocol {
  func AddAirline(airline: AirlineViewModel, complete: @escaping (Bool, String?) -> ()) {
    apiService.addAirline(airline: airline) { success, error in
      switch success {
      case true:
        complete(true, nil)
        break
      case false:
        complete(false, error)
        break
      }
    }
  }
  
}

