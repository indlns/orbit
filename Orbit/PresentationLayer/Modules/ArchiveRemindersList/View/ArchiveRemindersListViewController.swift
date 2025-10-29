//
//  ArchiveRemindersListViewController.swift
//  Orbit
//
//  Created by Евгений Овчинников on 29.10.2025.
//

import UIKit

class ArchiveRemindersListViewController: UITableViewController {
    
    // MARK: UI
    
    var archiveRemindersListViewModel: ArchiveRemindersListViewModel!
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupNavigationBar()
        setupBindings()
    }
    
    // MARK: Setup
    
    private func setupTableView() {
        tableView.register(ArchiveReminderCell.self,
                           forCellReuseIdentifier: Constants.Cell.archiveReminderCellIdentifier,)
    }
    
    private func setupNavigationBar() {
        title = "Выполненые"
    }
    
    // MARK: Actions
    
    private func showDetails(for reminder: Reminders) {
        let detailsReminderController = DetailsReminderViewController(reminder: reminder)
        navigationController?.pushViewController(detailsReminderController, animated: true)
    }
    
    // MARK: SetupBindings
    
    func setupBindings() {
        self.archiveRemindersListViewModel = ArchiveRemindersListViewModel()
        self.archiveRemindersListViewModel.bindViewModelToView = {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
        archiveRemindersListViewModel.onShowDetails = { [weak self] reminder in
            self?.showDetails(for: reminder)
        }
    }
}
