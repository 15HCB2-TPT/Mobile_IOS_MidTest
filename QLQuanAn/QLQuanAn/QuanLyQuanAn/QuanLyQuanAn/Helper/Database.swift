//
//  Database.swift
//  BT_CoreData
//
//  Created by Hiroshi.Kazuo on 3/25/17.
//  Copyright © 2017 Hiroshi.Kazuo. All rights reserved.
//
//  Supports:
//    static var MOC: NSManagedObjectContext
//    static func save()
//    static func reset()
//    static func insert<T: NSManagedObject>(object: T)
//    static func delete<T: NSManagedObject>(object: T)
//    static func create<T: NSManagedObject>() -> T
//    static func create(entityName: String) -> NSManagedObject
//    static func select<T: NSManagedObject>(predicater: NSPredicate? = nil, sorter: [NSSortDescriptor]? = nil) -> [T]
//    static func select(entityName: String, predicater: NSPredicate? = nil, sorter: [NSSortDescriptor]? = nil) -> [NSManagedObject]
//    static func select<T: NSManagedObject>(limit: Int, predicater: NSPredicate? = nil, sorter: [NSSortDescriptor]? = nil) -> [T]
//    static func select(entityName: String, limit: Int, predicater: NSPredicate? = nil, sorter: [NSSortDescriptor]? = nil) -> [NSManagedObject]
//    static func count(entityName: String, predicater: NSPredicate? = nil) -> Int
//    static func isExistAndGet<T: NSManagedObject>(predicater: NSPredicate?, getter: inout T?) -> Bool
//    static func isExistAndGet(entityName: String, predicater: NSPredicate?, getter: inout NSManagedObject?) -> Bool
//    static func isExist(entityName: String, predicater: NSPredicate?) -> Bool
//    static func isEmpty(entityName: String) -> Bool
//    static func clear(entityName: String)
//
//  Version 1.3
//  Change-log:
//      - 1.1: Remove func seedData.
//      - 1.2: Remove module Immediate.
//      - 1.3: Add isEmpty
//

import UIKit
import CoreData

//  CoreData: Enable AppDelegate-Context (Swift 3)
//==================================================
//extension AppDelegate {
//    // MARK: - Core Data stack
//    lazy var persistentContainer: NSPersistentContainer = {
//        let container = NSPersistentContainer(name: "BT_CoreData")
//        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
//            if let error = error as NSError? {
//                fatalError("Unresolved error \(error), \(error.userInfo)")
//            }
//        })
//        return container
//    }()
//}
//==================================================

class Database {
    static var MOC: NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    static func save() {
        if MOC.hasChanges {
            do {
                try MOC.save()
            }
            catch let error as NSError {
                print("Cannot save db \(error)")
            }
        }
    }
    
    static func reset() {
        MOC.reset()
    }
    
    static func insert<T: NSManagedObject>(object: T) {
        MOC.insert(object)
    }
    
    static func delete<T: NSManagedObject>(object: T) {
        MOC.delete(object)
    }
    
    static func create<T: NSManagedObject>() -> T {
        return NSEntityDescription.insertNewObject(forEntityName: GenericTypeHelper<T>.genericName(), into: MOC) as! T
    }
    
    static func create(entityName: String) -> NSManagedObject {
        return NSEntityDescription.insertNewObject(forEntityName: entityName, into: MOC)
    }
    
    static func select<T: NSManagedObject>(predicater: NSPredicate? = nil, sorter: [NSSortDescriptor]? = nil) -> [T] {
        let entityName = GenericTypeHelper<T>.genericName()
        let fetchRequest: NSFetchRequest<T> = NSFetchRequest(entityName: entityName)
        fetchRequest.predicate = predicater
        fetchRequest.sortDescriptors = sorter
        do {
            return try MOC.fetch(fetchRequest as! NSFetchRequest<NSFetchRequestResult>) as! [T]
        } catch let error as NSError {
            print("Cannot get all from entity \(entityName), error: \(error), \(error.userInfo)")
            return []
        }
    }
    
    static func select(entityName: String, predicater: NSPredicate? = nil, sorter: [NSSortDescriptor]? = nil) -> [NSManagedObject] {
        let fetchRequest: NSFetchRequest<NSManagedObject> = NSFetchRequest(entityName: entityName)
        fetchRequest.predicate = predicater
        fetchRequest.sortDescriptors = sorter
        do {
            return try MOC.fetch(fetchRequest as! NSFetchRequest<NSFetchRequestResult>) as! [NSManagedObject]
        } catch let error as NSError {
            print("Cannot get all from entity \(entityName), error: \(error), \(error.userInfo)")
            return []
        }
    }
    
    static func select<T: NSManagedObject>(limit: Int, predicater: NSPredicate? = nil, sorter: [NSSortDescriptor]? = nil) -> [T] {
        let entityName = GenericTypeHelper<T>.genericName()
        let fetchRequest: NSFetchRequest<T> = NSFetchRequest(entityName: entityName)
        fetchRequest.fetchLimit = limit
        fetchRequest.predicate = predicater
        fetchRequest.sortDescriptors = sorter
        do {
            return try MOC.fetch(fetchRequest as! NSFetchRequest<NSFetchRequestResult>) as! [T]
        } catch let error as NSError {
            print("Cannot get all from entity \(entityName), error: \(error), \(error.userInfo)")
            return []
        }
    }
    
    static func select(entityName: String, limit: Int, predicater: NSPredicate? = nil, sorter: [NSSortDescriptor]? = nil) -> [NSManagedObject] {
        let fetchRequest: NSFetchRequest<NSManagedObject> = NSFetchRequest(entityName: entityName)
        fetchRequest.fetchLimit = limit
        fetchRequest.predicate = predicater
        fetchRequest.sortDescriptors = sorter
        do {
            return try MOC.fetch(fetchRequest as! NSFetchRequest<NSFetchRequestResult>) as! [NSManagedObject]
        } catch let error as NSError {
            print("Cannot get all from entity \(entityName), error: \(error), \(error.userInfo)")
            return []
        }
    }
    
    static func count(entityName: String, predicater: NSPredicate? = nil) -> Int {
        let fetchRequest: NSFetchRequest<NSManagedObject> = NSFetchRequest(entityName: entityName)
        fetchRequest.predicate = predicater
        do {
            return try MOC.count(for: fetchRequest)
        } catch let error as NSError {
            print("Cannot count from entity \(entityName), error: \(error), \(error.userInfo)")
            return -1
        }
    }
    
    static func isExistAndGet<T: NSManagedObject>(predicater: NSPredicate?) -> T? {
        let results: [T] = select(limit: 1, predicater: predicater)
        if results.count > 0 {
            return results.first
        }
        return nil
    }
    
    static func isExistAndGet(entityName: String, predicater: NSPredicate?) -> NSManagedObject? {
        let results: [NSManagedObject] = select(entityName: entityName, limit: 1, predicater: predicater)
        if results.count > 0 {
            return results.first
        }
        return nil
    }
    
    static func isExist(entityName: String, predicater: NSPredicate?) -> Bool {
        return select(entityName: entityName, limit: 1, predicater: predicater).count > 0
    }
    
    static func isEmpty(entityName: String) -> Bool {
        return select(entityName: entityName, limit: 1).count == 0
    }
    
    static func clear(entityName: String) {
        for obj in Database.select(entityName: entityName) {
            Database.delete(object: obj)
        }
    }
}
