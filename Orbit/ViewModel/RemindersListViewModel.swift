//
//  RemindersListViewModel.swift
//  Orbit
//
//  Created by Евгений Овчинников on 27.10.2025.
//

import Foundation

class RemindersListViewModel: NSObject {
    
    private var coreDataService: CoreDataService!
    
    private(set) var remindersModel: [RemindersModel]? {
        didSet {
            self.bindViewModelToView()
        }
    }
    
    var bindViewModelToView: (() -> ()) = {}
    
    override init() {
        super.init()
        self.coreDataService = CoreDataService()
        getRemiders()
    }
    
    // MARK: Setup
    
    func getRemiders() {
        let reminders = ReminderFactory.create()
        self.remindersModel = reminders
    }
}
