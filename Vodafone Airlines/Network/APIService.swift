//
//  APIService.swift
//  Vodafone Airlines
//
//  Created by Hassan Ashraf on 03/10/2021.
//

import Foundation

enum APIError: String, Error {
  case noNetwork = "No Network"
  case serverOverload = "Server is overloaded"
  case permissionDenied = "You don't have permission"
}

class APIService {
  
  static func fetchAirlinesData(complete: @escaping (Bool, [Airline], String?) -> ()) {
    DispatchQueue.global().async {
      sleep(3)
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
        complete(true, result.airlines, nil)
      } catch let error {
        print("decoding error: \(error)")
        complete(false, [], error.localizedDescription)
      }
    }
    
  }
}
