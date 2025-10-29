//
//  ArchiveRemindersListViewModel.swift
//  Orbit
//
//  Created by Евгений Овчинников on 29.10.2025.
//

import Foundation
import CoreData

class ArchiveRemindersListViewModel: NSObject {
    
    private var coreDataService: CoreDataService!
    
    private(set) var remindersModel: [Reminders]? {
        didSet {
            self.bindViewModelToView()
        }
    }
    
    var bindViewModelToView: (() -> ()) = {}
    var onShowDetails: ((Reminders) -> Void)?
    
    override init() {
        super.init()
        self.coreDataService = CoreDataService()
        fetchRemiders()
    }
    
    // MARK: Setup
    
    func fetchRemiders() {
        let context = coreDataService.context
        let request: NSFetchRequest<Reminders> = Reminders.fetchRequest()
        do {
            let allReminders = try context.fetch(request)
            remindersModel = allReminders.filter { $0.isDone == true }
        } catch {
            print("Ошибка загрузки: \(error)")
        }
    }
    
    func deleteReminder(reminder: Reminders) {
        coreDataService.deleteReminder(reminder: reminder)
        fetchRemiders()
    }
    
    func didSelectReminder(at index: Int) {
        guard let reminder = remindersModel?[index] else { return }
        onShowDetails?(reminder)
    }
}
