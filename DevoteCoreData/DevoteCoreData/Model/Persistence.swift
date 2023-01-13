//
//  Persistence.swift
//  DevoteCoreData
//
//  Created by Gurjinder Singh on 11/01/23.
//

import CoreData

struct PersistenceController {
    
    //MARK: - 1.Persistance Controller
    static let shared = PersistenceController()
    
    //MARK: - 2.Persistance container
    let container: NSPersistentContainer
    
    //MARK: - 3.Initialization(laod persistance store)
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "DevoteCoreData")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
    
    //MARK: - 3.preview
    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        for _ in 0..<10 {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()
        }
        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()
}
