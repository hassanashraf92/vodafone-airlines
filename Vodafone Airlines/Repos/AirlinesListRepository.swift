//
//  AirlinesListRepository.swift
//  Vodafone Airlines
//
//  Created by Hassan Ashraf on 03/10/2021.
//

import Foundation

protocol AirlinesListRepositoryProtocol {
  func fetchAirlinesData( complete: @escaping ( _ success: Bool, _ airlines: [AirlineResponse], _ error: String? )->() )
}

class AirlinesListRepository {
  
  var fetchData: (() -> ())?
  private let apiService: AirlinesRemoteRepository
  private var dbContainer: CoreDataStorage?
  
  init() {
    self.apiService = AirlinesRemoteRepository()
    self.dbContainer = CoreDataStorage.shared
  }
  
  private func saveToCoreData(for entityName: String, data: [AirlineResponse], completion: @escaping (_ finished: Bool) -> ()) {
    CoreDataStorage.shared.clearStorage(forEntity: entityName)
    data.forEach { $0.store() }
    completion(true)
    let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
    print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@")
    print(paths[0])
  }
  
  
  private func fetchFromCoreData() -> [AirlineResponse] {
    let airlines = CoreDataStorage.shared.fetch(Airline.self)
    var airlinesResponse = [AirlineResponse]()
    airlines.forEach {
      airlinesResponse.append(AirlineResponse($0))
    }
    return airlinesResponse
  }
}

extension AirlinesListRepository: AirlinesListRepositoryProtocol {
  
  func fetchAirlinesData(complete: @escaping (Bool, [AirlineResponse], String?) -> ()) {
    
    apiService.fetchAirlinesData { success, airlines, error in
      switch success {
      case true:
        DispatchQueue.main.async {
          //TODO: Save to DB
          self.saveToCoreData(for: "Airline", data: airlines) { finished in
            complete(true, airlines, nil)
          }
        }
        break
      case false:
        DispatchQueue.main.async {
          //TODO: Get from DB
          complete(true, self.fetchFromCoreData(), nil)
        }
        break
      }
    }
  }
}
