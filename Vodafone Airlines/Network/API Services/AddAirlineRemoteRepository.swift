//
//  AddAirlineRemoteRepository.swift
//  Vodafone Airlines
//
//  Created by Hassan Ashraf on 05/10/2021.
//

import Foundation

class AddAirlineRemoteRepository {
  
  func addAirline(airline: AirlineViewModel, complete: @escaping (Bool, String?) -> ()) {
    let parameters: [String: Any] = ["name": airline.name ?? "",
                                     "country": airline.country ?? "",
                                     "slogan": airline.slogan ?? "",
                                     "head_quaters": airline.address ?? "",
                                     "website": airline.website ?? ""
    ]
    
    print("Adding Airline Parameters \(parameters)")
    
    APIManager.shared().request(type: EndPointItem.addNewAirline, params: parameters) { (airline: AirlineResponse?, error: String?) in
      guard error == nil else {
        complete(false, error)
        return
      }
      guard let _ = airline else { return }
      complete(true, nil)
    }
  }
}
