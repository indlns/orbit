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
        callToViewModelForUIUpdate()
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
        print("tap tap")
    }
    
    func callToViewModelForUIUpdate() {
            self.remindersListViewModel = RemindersListViewModel()
            self.remindersListViewModel.bindViewModelToView = {
                self.updateDataSource()
            }
        }
        
        func updateDataSource() {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    
    // MARK: Layout
}
