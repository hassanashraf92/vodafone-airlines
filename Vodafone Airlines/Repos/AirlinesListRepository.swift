//
//  AirlinesListRepository.swift
//  Vodafone Airlines
//
//  Created by Hassan Ashraf on 03/10/2021.
//

import Foundation

protocol AirlinesListRepositoryProtocol {
  func fetchAirlinesData( complete: @escaping ( _ success: Bool, _ airlines: [Airline], _ error: String? )->() )
}

class AirlinesListRepository {
  
  var fetchData: (() -> ())?
  private let apiService: AirlinesRemoteRepository
  private var dbContainer: CoreDataStorage?
  
  init() {
    self.apiService = AirlinesRemoteRepository()
    self.dbContainer = CoreDataStorage.shared
  }
  
  private func saveToCoreData(for entityName: String, data: Airlines, completion: @escaping (_ finished: Bool) -> ()) {
    CoreDataStorage.shared.clearStorage(forEntity: entityName)
    data.forEach { $0.store() }
    completion(true)
    let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
    print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@")
    print(paths[0])
  }
  
  
  private func fetchFromCoreData() -> [Airline] {
//    let ss = CoreDataStorage.shared.fetchData(entityName: "Airline") as! [Airline]
    let airlines = CoreDataStorage.shared.fetch(Airline.self)
    return airlines
  }
}

extension AirlinesListRepository: AirlinesListRepositoryProtocol {
  
  func fetchAirlinesData(complete: @escaping (Bool, [Airline], String?) -> ()) {
    
    apiService.fetchAirlinesData { success, airlines, error in
      switch success {
      case true:
        DispatchQueue.main.async {
          //TODO: Save to DB
          self.saveToCoreData(for: "Airline", data: airlines) { finished in
            complete(true, self.fetchFromCoreData(), nil)
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
