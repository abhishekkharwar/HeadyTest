//
//  DatabaseManager.swift
//  HeadyTest
//
//  Created by Abhishek Kumar on 27/07/20.
//  Copyright © 2020 Abhishek Kumar. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class DatabaseManager: NSObject {
    
    static let sharedManager = DatabaseManager()

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: AppConstants.dbModelName)
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

    func saveContext () {
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
    
    func createEntityWithName(entityName: String) -> NSManagedObject?
    {
        let context = persistentContainer.viewContext
        
        if let description = NSEntityDescription.entity(forEntityName: entityName, in: context){
            return NSManagedObject.init(entity: description, insertInto: context)
        }
    
        return nil
    }
    
    func deleteEntityObject(object: NSManagedObject){
        
        persistentContainer.viewContext.delete(object)
    }
    
    func fetchObjectsFromEntity(entityName: String, predicate: NSPredicate?) -> [NSManagedObject]
    {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        
        fetchRequest.predicate = predicate
        var resultArray = [NSManagedObject]()
        
        let context = persistentContainer.viewContext
        
        do{
            resultArray = try context.fetch(fetchRequest)
        }
        catch{
            
        }
        
        return resultArray
    }
    
    func saveChanges() ->Bool
    {
        let context = persistentContainer.viewContext
        
        do{
            try context.save()
        }
        catch{
            return false
        }
        return true
    }
}
