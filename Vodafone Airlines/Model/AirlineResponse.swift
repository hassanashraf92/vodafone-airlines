//
//  AirlineResponse.swift
//  Vodafone Airlines
//
//  Created by Hassan Ashraf on 03/10/2021.
//

import Foundation

// MARK: - Airline
struct AirlineResponse: Codable {
  var id: Int?
  var name, country: String?
  var logo: String?
  var slogan, headQuaters, website, established: String?
  var requestedID: String?
  
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
    airline.address = headQuaters
    AirlineResponse.storage.save()
  }
  
  func convert() -> Airline? { //For testing purpose..
    let airline = Airline()
    airline.id = Int16(id ?? 0)
    airline.name = name ?? ""
    airline.country = country ?? ""
    airline.established = established
    airline.logo = logo
    airline.slogan = slogan
    airline.website = website
    airline.address = headQuaters
    return airline
  }
  
  init(_ airline: Airline) {
    self.id = Int(airline.id)
    self.name = airline.name
    self.country = airline.country
    self.established = airline.established
    self.logo = airline.logo
    self.slogan = airline.slogan
    self.website = airline.website
    self.headQuaters = airline.address
  }
  
}

struct AirlineViewModel {
  var id: Int?
  var name: String?
  var country: String?
  var address: String?
  var slogan: String?
  var website: String?
  var searchQuery: String?
  
  
  init() {}
  
  init(_ airline: AirlineResponse) {
    self.id = airline.id
    self.name = airline.name
    self.country = airline.country
    self.address = airline.headQuaters
    self.slogan = airline.slogan
    self.website = airline.website
    self.searchQuery = "\(id)\(name)\(country)"
    
  }
  
}
