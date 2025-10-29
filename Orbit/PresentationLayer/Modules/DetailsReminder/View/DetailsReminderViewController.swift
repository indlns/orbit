//
//  DetailsReminderViewController.swift
//  Orbit
//
//  Created by Евгений Овчинников on 29.10.2025.
//

import UIKit

class DetailsReminderViewController: UIViewController {
    
    // MARK: UI
    
    private let reminder: Reminders
    var detailsReminderViewModel: DetailsReminderViewModel!
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavigationBar()
        setupBindings()
    }
    
    init(reminder: Reminders) {
        self.reminder = reminder
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Setup
    
    private func setupNavigationBar() {
        title = reminder.title
    }
    
    // MARK: Actions
    
    // MARK: SetupBindings
    
    func setupBindings() {
        self.detailsReminderViewModel = DetailsReminderViewModel()
        self.detailsReminderViewModel.bindViewModelToView = {
        }
    }
}
