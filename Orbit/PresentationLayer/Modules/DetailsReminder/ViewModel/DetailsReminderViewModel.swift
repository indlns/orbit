//
//  DetailsReminderViewModel.swift
//  Orbit
//
//  Created by Евгений Овчинников on 29.10.2025.
//

import Foundation
import CoreData

class DetailsReminderViewModel: NSObject {
    
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
    }
    
    // MARK: Setup
}
