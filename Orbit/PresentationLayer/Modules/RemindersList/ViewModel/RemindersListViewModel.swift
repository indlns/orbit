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
    var onShowDetails: ((Reminders) -> Void)?
    var onShowArchive: (() -> Void)?
    
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
            remindersModel = allReminders.filter { !$0.isDone }
        } catch {
            print("Ошибка загрузки: \(error)")
        }
    }
    
    func saveRemidner(title: String, desc: String, date: Date, endDate: Date) {
        coreDataService.saveReminder(title: title, desc: desc, date: date, endDate: endDate)
        fetchRemiders()
    }
    
    func deleteReminder(reminder: Reminders) {
        coreDataService.deleteReminder(reminder: reminder)
        fetchRemiders()
    }
    
    func makeCompleted(reminder: Reminders) {
        coreDataService.makeCompleted(reminder: reminder)
        fetchRemiders()
    }
    
    func didSelectReminder(at index: Int) {
        guard let reminder = remindersModel?[index] else { return }
        onShowDetails?(reminder)
    }
}
