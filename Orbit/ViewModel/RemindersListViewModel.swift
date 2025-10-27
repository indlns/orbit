//
//  RemindersListViewModel.swift
//  Orbit
//
//  Created by Евгений Овчинников on 27.10.2025.
//

import Foundation
import CoreData

class RemindersListViewModel: NSObject {
    
    private var coreDataService: CoreDataService!
    
    private(set) var remindersModel: [Reminders]? {
        didSet {
            self.bindViewModelToView()
        }
    }
    
    var bindViewModelToView: (() -> ()) = {}
    
    override init() {
        super.init()
        self.coreDataService = CoreDataService()
        fetchRemiders()
    }
    
    // MARK: Setup
    
    func fetchRemiders() {
        let context = CoreDataService.shared.context
        let request: NSFetchRequest<Reminders> = Reminders.fetchRequest()
        do {
            remindersModel = try context.fetch(request)
        } catch {
            print("Ошибка загрузки: \(error)")
        }
    }
    
    func saveRemidner(title: String, desc: String, date: String) {
        coreDataService.saveReminder(title: title, desc: desc, date: date)
        fetchRemiders()
    }
}
