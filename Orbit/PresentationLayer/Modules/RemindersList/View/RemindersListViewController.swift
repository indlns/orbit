//
//  ViewController.swift
//  Orbit
//
//  Created by Евгений Овчинников on 27.10.2025.
//

import UIKit

class RemindersListViewController: UITableViewController {
    
    // MARK: UI
    
    var remindersListViewModel: RemindersListViewModel!
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupNavigationBar()
        setupBindings()
    }
    
    // MARK: Setup
    
    private func setupTableView() {
        tableView.register(ReminderCell.self,
                           forCellReuseIdentifier: Constants.Cell.reminderCellIdentifier)
    }
    
    private func setupNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                            target: self,
                                                            action: #selector(searchAction))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .bookmarks,
                                                            target: self,
                                                            action: #selector(openArchive))
    }
    
    // MARK: Actions
    
    @objc private func searchAction() {
        AlertManager.makeNewReminderAlert(on: self) { title, desc, date, endDate in
            self.remindersListViewModel.saveRemidner(title: title,
                                                     desc: desc,
                                                     date: date,
                                                     endDate: endDate)
        }
    }
    
    @objc private func openArchive() {
        let archiveController = ArchiveRemindersListViewController()
        navigationController?.pushViewController(archiveController, animated: true)
    }
    
    private func showDetails(for reminder: Reminders) {
        let detailsReminderController = DetailsReminderViewController(reminder: reminder)
        navigationController?.pushViewController(detailsReminderController, animated: true)
    }
    
    // MARK: SetupBindings
    
    func setupBindings() {
        self.remindersListViewModel = RemindersListViewModel()
        self.remindersListViewModel.bindViewModelToView = {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
        remindersListViewModel.onShowDetails = { [weak self] reminder in
            self?.showDetails(for: reminder)
        }
    }
}
