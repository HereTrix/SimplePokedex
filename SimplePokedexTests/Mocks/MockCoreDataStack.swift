//
//  MockCoreDataStack.swift
//  SimplePokedexTests
//
//  Created by Ihor Bochko on 10/8/20.
//

import Foundation

import CoreData

class MockCoreDataStack {
    
    static let shared = MockCoreDataStack()
    
    lazy var managedObjectContext: NSManagedObjectContext = {
        let managedObjectModel = NSManagedObjectModel.mergedModel(from: [Bundle.main])!
        
        let persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel)
        
        do {
            try persistentStoreCoordinator.addPersistentStore(ofType: NSInMemoryStoreType, configurationName: nil, at: nil, options: nil)
        } catch {
            print("Adding in-memory persistent store failed")
        }
        
        let managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = persistentStoreCoordinator
        return managedObjectContext
    }()
}
