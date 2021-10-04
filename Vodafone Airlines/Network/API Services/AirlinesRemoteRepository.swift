//
//  APIService.swift
//  Vodafone Airlines
//
//  Created by Hassan Ashraf on 03/10/2021.
//

import Foundation

class AirlinesRemoteRepository {
  
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
