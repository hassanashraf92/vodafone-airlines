//
//  Airline+CoreDataClass.swift
//  Vodafone Airlines
//
//  Created by Hassan Ashraf on 03/10/2021.
//
//

import Foundation
import CoreData

class Airline: NSManagedObject, Codable {

  @NSManaged var id: String
  @NSManaged var name: String
  
  enum CodingKeys: String, CodingKey {
    case id
    case name
  }
  
  required convenience init(from decoder: Decoder) throws {
    
    guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.managedObjectContext,
          let managedObjectContext = decoder.userInfo[codingUserInfoKeyManagedObjectContext] as? NSManagedObjectContext,
          let entity = NSEntityDescription.entity(forEntityName: "Airline", in: managedObjectContext) else {
      fatalError("Failed to decode User")
    }
    
    self.init(entity: entity, insertInto: managedObjectContext)
    
    let container = try decoder.container(keyedBy: CodingKeys.self)
    id = try container.decode(String.self, forKey: .id)
    name = try container.decode(String.self, forKey: .name)
  }
  
  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(name, forKey: .name)
  }
  
}


public extension CodingUserInfoKey {
  // Helper property to retrieve the Core Data managed object context
  static let managedObjectContext = CodingUserInfoKey(rawValue: "managedObjectContext")
}
