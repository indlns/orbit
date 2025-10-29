//
//  RemindersListExtensions.swift
//  Orbit
//
//  Created by Евгений Овчинников on 27.10.2025.
//

import UIKit

extension RemindersListViewController {
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        120
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        remindersListViewModel.remindersModel?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Cell.reminderCellIdentifier, for: indexPath) as! ReminderCell
        guard let item = remindersListViewModel.remindersModel?[indexPath.row] else { return cell }
        cell.configure(model: item)
        cell.makeCompleted = { [weak self] model in
            self?.remindersListViewModel.makeCompleted(reminder: model)
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        remindersListViewModel.didSelectReminder(at: indexPath.row)
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Удалить") { [weak self] _, _, completion in
            guard let self = self, let reminder = self.remindersListViewModel.remindersModel?[indexPath.row] else { return }
            
            remindersListViewModel.deleteReminder(reminder: reminder)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
            completion(true)
        }
        
        deleteAction.backgroundColor = .red
        deleteAction.image = UIImage(systemName: "trash")
        
        let config = UISwipeActionsConfiguration(actions: [deleteAction])
        config.performsFirstActionWithFullSwipe = true
        return config
    }
}
