//
//  AirlineResponse.swift
//  Vodafone Airlines
//
//  Created by Hassan Ashraf on 03/10/2021.
//

import Foundation

typealias Airlines = [AirlineResponse]

// MARK: - Airline
struct AirlineResponse: Codable {
  let id: Int?
  let name, country: String?
  let logo: String?
  let slogan, headQuaters, website, established: String?
  let requestedID: String?
  
  enum CodingKeys: String, CodingKey {
    case id, name, country, logo, slogan
    case headQuaters = "head_quaters"
    case website, established
    case requestedID = "requestedId"
  }
  
  static let storage = CoreDataStorage.shared
  
  func store() {
    guard let airline = AirlineResponse.storage.add(Airline.self) else { return }
    guard let id = id, let name = name, let country = country else { return }
    airline.id = Int16(id)
    airline.name = name
    airline.country = country
    airline.established = established
    airline.logo = logo
    airline.slogan = slogan
    airline.website = website
    AirlineResponse.storage.save()
  }
  
}
