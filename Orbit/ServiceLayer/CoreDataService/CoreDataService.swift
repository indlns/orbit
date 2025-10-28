//
//  CoreDataService.swift
//  Orbit
//
//  Created by Евгений Овчинников on 27.10.2025.
//

import Foundation
import CoreData

class CoreDataService {    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Orbit")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    var context: NSManagedObjectContext {
        persistentContainer.viewContext
    }
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    // MARK: - Actions
    
    func saveReminder(title: String, desc: String, date: Date) {
        let reminder = Reminders(context: context)
        reminder.title = title
        reminder.desc = desc
        reminder.date = date
        saveContext()
    }
    
    func deleteReminder(reminder: Reminders) {
        context.delete(reminder)
        saveContext()
    }
}
