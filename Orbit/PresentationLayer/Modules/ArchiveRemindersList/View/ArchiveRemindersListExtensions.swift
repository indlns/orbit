//
//  ArchiveRemindersListExtensions.swift
//  Orbit
//
//  Created by Евгений Овчинников on 29.10.2025.
//

import UIKit

extension ArchiveRemindersListViewController {
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        archiveRemindersListViewModel.remindersModel?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Cell.archiveReminderCellIdentifier, for: indexPath) as! ArchiveReminderCell
        guard let item = archiveRemindersListViewModel.remindersModel?[indexPath.row] else { return cell }
        cell.configure(model: item)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        archiveRemindersListViewModel.didSelectReminder(at: indexPath.row)
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Удалить") { [weak self] _, _, completion in
            guard let self = self, let reminder = self.archiveRemindersListViewModel.remindersModel?[indexPath.row] else { return }
            
            archiveRemindersListViewModel.deleteReminder(reminder: reminder)
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
