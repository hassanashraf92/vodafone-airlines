//
//  Airline.swift
//  Vodafone Airlines
//
//  Created by Hassan Ashraf on 04/10/2021.
//

import Foundation
import CoreData

public class Airline: NSManagedObject {
  @NSManaged var id: Int16
  @NSManaged var name: String
  @NSManaged var country: String
  @NSManaged var logo: String?
  @NSManaged var slogan: String?
  @NSManaged var established: String?
  @NSManaged var website: String?
  @NSManaged var address: String?
}
