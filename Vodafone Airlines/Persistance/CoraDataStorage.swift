//
//  CoraDataStorage.swift
//  Vodafone Airlines
//
//  Created by Hassan Ashraf on 03/10/2021.
//

import Foundation
import CoreData

class CoreDataStorage: NSObject {
  
  static let shared = CoreDataStorage()
  
  //MARK: Coredata stack
  var persistentContainer: NSPersistentContainer = {
    /*
     The persistent container for the application. This implementation
     creates and returns a container, having loaded the store for the
     application to it. This property is optional since there are legitimate
     error conditions that could cause the creation of the store to fail.
     */
    let container = NSPersistentContainer(name: "Vodafone_Airlines")
    container.loadPersistentStores(completionHandler: { (storeDescription, error) in
      if let error = error as NSError? {
        // Replace this implementation with code to handle the error appropriately.
        // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        
        /*
         Typical reasons for an error here include:
         * The parent directory does not exist, cannot be created, or disallows writing.
         * The persistent store is not accessible, due to permissions or data protection when the device is locked.
         * The device is out of space.
         * The store could not be migrated to the current model version.
         Check the error message to determine what the actual problem was.
         */
        fatalError("Unresolved error \(error), \(error.userInfo)")
      }
    })
    return container
  }()
  
  // MARK: - Core Data Saving support
  
  func saveContext() {
    let context = persistentContainer.viewContext
    if context.hasChanges {
      do {
        try context.save()
      } catch {
        // Replace this implementation with code to handle the error appropriately.
        // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        let nserror = error as NSError
        fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
      }
    }
  }
  
  func managedObjectContext() -> NSManagedObjectContext {
    return persistentContainer.viewContext
  }
  
  func save() {
    do {
      try managedObjectContext().save()
    } catch {
      print(error.localizedDescription)
    }
  }
  
  func add<T: NSManagedObject>(_ type: T.Type) -> T? {
    guard let entityName = T.entity().name else { return nil }
    guard let entity = NSEntityDescription.entity(forEntityName: entityName, in: managedObjectContext()) else { return nil }
    let object = T(entity: entity, insertInto: managedObjectContext())
    return object
  }
  
  func clearStorage(forEntity entity: String) {
    let isInMemoryStore = persistentContainer.persistentStoreDescriptions.reduce(false) {
      return $0 ? true : $1.type == NSInMemoryStoreType
    }
    
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
    if isInMemoryStore {
      do {
        let entities = try managedObjectContext().fetch(fetchRequest)
        for entity in entities {
          managedObjectContext().delete(entity as! NSManagedObject)
        }
      } catch let error as NSError {
        print(error)
      }
    } else {
      let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
      do {
        try managedObjectContext().execute(batchDeleteRequest)
      } catch let error as NSError {
        print(error)
      }
    }
  }
  
  func fetch<T: NSManagedObject>(_ type: T.Type) -> [T] {
    guard let entityName = T.entity().name else { return [] }
    let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
    let context = managedObjectContext()
    
//    let request = T.fetchRequest()
    
    do {
      let result = try context.fetch(fetchRequest)
      print("Result of Fetching from CoreData is \(result.debugDescription)")
      return result as! [T]
    } catch {
      print("Fetch failed..")
      return []
    }
    
//    do {
//      let result = try managedObjectContext().fetch(request)
//      return result as! [T]
//    } catch {
//      print(error.localizedDescription)
//      return []
//    }
  }
  
  func fetchData(entityName: String) -> [NSManagedObject] {
    let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
    let context = managedObjectContext()
    do {
      let result = try context.fetch(fetchRequest)
      print("Result of Fetching from CoreData is \(result.debugDescription)")
      return result
    } catch {
      print("Fetch failed..")
      return []
    }
    
  }
}
