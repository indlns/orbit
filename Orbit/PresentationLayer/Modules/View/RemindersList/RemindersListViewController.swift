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
                           forCellReuseIdentifier: Constants.ReminderCell.identifier)
    }
    
    private func setupNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                            target: self,
                                                            action: #selector(searchAction))
    }
    
    // MARK: Actions
    
    @objc private func searchAction() {
        AlertManager.makeNewReminderAlert(on: self) { title, desc, date in
            self.remindersListViewModel.saveRemidner(title: title,
                                                     desc: desc,
                                                     date: date)
        }
    }
    
    // MARK: SetupBindings
    
    func setupBindings() {
        self.remindersListViewModel = RemindersListViewModel()
        self.remindersListViewModel.bindViewModelToView = {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}
