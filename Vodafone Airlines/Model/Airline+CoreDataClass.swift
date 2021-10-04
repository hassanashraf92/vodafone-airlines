//
//  Airline+CoreDataClass.swift
//  Vodafone Airlines
//
//  Created by Hassan Ashraf on 03/10/2021.
//
//

import Foundation
import CoreData

@objc(Airline)
public class Airline: NSManagedObject, Codable {
  
  enum CodingKeys: CodingKey {
      case id, name
   }
  
  required convenience public init(from decoder: Decoder) throws {
    print("<<<<<<<<>>>>>>>")
    print(CodingUserInfoKey.managedObjectContext)
    print(decoder.userInfo[CodingUserInfoKey.managedObjectContext!])
    
    guard let managedObjectContext = CodingUserInfoKey.managedObjectContext,
          let context = decoder.userInfo[managedObjectContext] as? NSManagedObjectContext else {
      fatalError("Failed to decode User")
    }
    
    self.init(context: context)
    
    let container = try decoder.container(keyedBy: CodingKeys.self)
    self.id = try container.decode(Int.self, forKey: .id)
    self.name = try container.decode(String.self, forKey: .name)
  }
  
  public func encode(to encoder: Encoder) throws {
      var container = encoder.container(keyedBy: CodingKeys.self)
      try container.encode(id, forKey: .id)
      try container.encode(name, forKey: .name)
    }
  
}

extension Airline {
  
  @nonobjc public class func fetchRequest() -> NSFetchRequest<Airline> {
    return NSFetchRequest<Airline>(entityName: "Airline")
  }
  
  @NSManaged public var id: Int
  @NSManaged public var name: String
  
}

extension Airline: Identifiable {}

//class Airline: NSManagedObject, Codable {
//
//  @NSManaged var id: Int
//  @NSManaged var name: String
//  var country: String?
//  var logo: String?
//  var slogan, headQuaters, website, established: String?
//  var requestedID: String?
//
//  enum CodingKeys: String, CodingKey {
//    case id, name, country, logo, slogan
//    case headQuaters = "head_quaters"
//    case website, established
//    case requestedID = "requestedId"
//  }
//
//  required convenience init(from decoder: Decoder) throws {
//
//    guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.managedObjectContext,
//          let managedObjectContext = decoder.userInfo[codingUserInfoKeyManagedObjectContext] as? NSManagedObjectContext,
//          let entity = NSEntityDescription.entity(forEntityName: "Airline", in: managedObjectContext) else {
//      fatalError("Failed to decode User")
//    }
//
//    self.init(entity: entity, insertInto: managedObjectContext)
//
//    let container = try decoder.container(keyedBy: CodingKeys.self)
//    id = try container.decode(Int.self, forKey: .id)
//    name = try container.decode(String.self, forKey: .name)
//
//  }
//
//  public func encode(to encoder: Encoder) throws {
//    var container = encoder.container(keyedBy: CodingKeys.self)
//    try container.encode(id, forKey: .id)
//    try container.encode(name, forKey: .name)
//
//  }
//
//}


public extension CodingUserInfoKey {
  // Helper property to retrieve the Core Data managed object context
  static let managedObjectContext = CodingUserInfoKey(rawValue: "managedObjectContext")
}
