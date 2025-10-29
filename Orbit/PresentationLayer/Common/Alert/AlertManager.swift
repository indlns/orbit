//
//  AlertManager.swift
//  Orbit
//
//  Created by Евгений Овчинников on 28.10.2025.
//

import UIKit

final class AlertManager {
    static func makeNewReminderAlert(on viewController: UIViewController,
                                     saveHandler: @escaping (_ title: String,
                                                             _ desc: String,
                                                             _ date: Date,
                                                             _ enddate: Date) -> Void) {
        let alert = UIAlertController(title: "Новое напоминание",
                                      message: "Введите данные",
                                      preferredStyle: .alert)
        
        alert.addTextField { $0.placeholder = "Название" }
        alert.addTextField { $0.placeholder = "Описание" }
        alert.addTextField { textField in
            textField.placeholder = "Окончание"
            textField.keyboardType = .numbersAndPunctuation
        }
        
        let saveAction = UIAlertAction(title: "Сохранить", style: .default) { _ in
            let title = alert.textFields?[0].text ?? ""
            let desc  = alert.textFields?[1].text ?? ""
            let endDateString = alert.textFields?[2].text ?? ""
            saveHandler(title, desc, .now, DateFormatHelper.getDate(from: endDateString))
        }
        
        alert.addAction(saveAction)
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel))
        
        viewController.present(alert, animated: true)
    }
}
