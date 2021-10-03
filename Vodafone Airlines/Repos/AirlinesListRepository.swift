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
  private let apiService: APIService
  private var dbContainer: CoreDataStorage?
  
  init() {
    self.apiService = APIService()
    self.dbContainer = CoreDataStorage.shared
  }
  
  private func saveToCoreData(for entityName: String) {
    CoreDataStorage.shared.clearStorage(forEntity: entityName)
    CoreDataStorage.shared.saveContext()
    
    let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
    print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@")
    print(paths[0])
  }
  
  private func getFromCoreData(completion: @escaping (_ airlines: [Airline]?,_ error: String?) -> ()) {
    //TODO: Retreive Data..
    let result = CoreDataStorage.shared.fetchData(entityName: "Airline")
    guard let airlines = result as? [Airline], !airlines.isEmpty else {
      completion(nil, "Empty Storage")
      return
    }
    completion(airlines, nil)
  }
  
}

extension AirlinesListRepository: AirlinesListRepositoryProtocol {
  
  func fetchAirlinesData(complete: @escaping (Bool, [Airline], String?) -> ()) {
    APIService.fetchAirlinesData { [weak self] success, airlines, error in
      switch success {
      case true:
        DispatchQueue.main.async {
          self?.saveToCoreData(for: "Airline")
        }
        complete(true, airlines, nil)
      case false:
        DispatchQueue.main.async {
          self?.getFromCoreData(completion: { airlines, error in
            guard airlines != nil else {
              complete(false, [], "First time run with no internet connection..")
              return
            }
            
            guard let airlines = airlines else { return }
            complete(true, airlines, nil)
          })
        }
      }
    }
  }
}
