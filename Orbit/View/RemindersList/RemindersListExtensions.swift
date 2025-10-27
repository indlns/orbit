//
//  RemindersListExtensions.swift
//  Orbit
//
//  Created by Евгений Овчинников on 27.10.2025.
//

import UIKit

extension RemindersListViewController {
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        remindersListViewModel.remindersModel?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.ReminderCell.identifier, for: indexPath) as! ReminderCell
        guard let item = remindersListViewModel.remindersModel?[indexPath.row] else { return cell }
        cell.configure(model: item)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
