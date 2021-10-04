//
//  AddAirlineRepository.swift
//  Vodafone Airlines
//
//  Created by Hassan Ashraf on 05/10/2021.
//

import Foundation

protocol AddAirlineRepositoryProtocol {
  func AddAirline(name: String, slogan: String, country: String, headquarter: String, website: String, complete: @escaping ( _ success: Bool, _ error: String? )->() )
}

class AddAirlineRepository {
  
  private let apiService: AddAirlineRemoteRepository
  
  init() {
    self.apiService = AddAirlineRemoteRepository()
  }
}

extension AddAirlineRepository: AddAirlineRepositoryProtocol {
  
  func AddAirline(name: String, slogan: String, country: String, headquarter: String, website: String, complete: @escaping (Bool, String?) -> ()) {
    apiService.addAirline(name: name, slogan: slogan, country: country, Headquarter: headquarter, website: website) { success, error in
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

