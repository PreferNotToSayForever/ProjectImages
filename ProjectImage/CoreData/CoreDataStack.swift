//
//  CoreDataStack.swift
//  Maliban Milk Product
//
//  Created by Quang Le Nguyen on 22/8/18.
//  Copyright © 2018 Quang Le Nguyen. All rights reserved.
//


import Foundation
import CoreData

class CoreDataStack {
    private let modelName: String
    init(modelName: String) {
        self.modelName = modelName
    }
    private lazy var storeContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: self.modelName)
        container.loadPersistentStores{ (storeDescription, error) in
            if let error = error as NSError? {
                print("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
   private lazy var saveManagedObjectContext: NSManagedObjectContext = {
        return storeContainer.newBackgroundContext()
    }()
    
    lazy var managedContext: NSManagedObjectContext = {
        let context = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        context.parent = saveManagedObjectContext
        return context
    }()
    
    func saveContext(){
        guard managedContext.hasChanges || saveManagedObjectContext.hasChanges else { return }
        managedContext.performAndWait {
            do {
                try self.managedContext.save()
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
        saveManagedObjectContext.perform {
            do {
                try self.saveManagedObjectContext.save()
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
    }
}
