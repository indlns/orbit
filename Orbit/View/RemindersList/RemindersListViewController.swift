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
    private var remindersModel: [Reminders] = []
    
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
        let alert = UIAlertController(title: "Новое напоминание",
                                      message: "Введите текст",
                                      preferredStyle: .alert)
        alert.addTextField { $0.placeholder = "Название" }
        alert.addTextField { $0.placeholder = "Описание" }
        alert.addTextField { $0.placeholder = "Дата" }
        
        alert.addAction(UIAlertAction(title: "Сохранить", style: .default) { _ in
            let title = alert.textFields?[0].text ?? ""
            let desc = alert.textFields?[1].text ?? ""
            let date = alert.textFields?[1].text ?? ""
            self.saveReminder(title: title, desc: desc, date: date)
        })
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel))
        present(alert, animated: true)
    }
    
    private func saveReminder(title: String,
                              desc: String,
                              date: String) {
        remindersListViewModel.saveRemidner(title: title,
                                            desc: desc,
                                            date: date)
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
