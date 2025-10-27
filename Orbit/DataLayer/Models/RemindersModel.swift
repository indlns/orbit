//
//  RemindersModel.swift
//  Orbit
//
//  Created by Евгений Овчинников on 27.10.2025.
//

import Foundation

struct RemindersModel {
    let title: String
    let desc: String
    let date: String
    let isDone: Bool
    let endDate: String
    
    init(title: String,
         desc: String,
         date: String,
         isDonde: Bool,
         endDate: String) {
        self.title = title
        self.desc = desc
        self.date = date
        self.isDone = isDonde
        self.endDate = endDate
    }
}

class ReminderFactory {
   static func create() -> [RemindersModel] {
        return [RemindersModel(title: "Позвонить",
                               desc: "Напомнить о звонке",
                               date: "20.10.25",
                               isDonde: true,
                               endDate: "20.12.25"),
                RemindersModel(title: "Купить молоко", desc: "В магазине",
                               date: "20.10.25",
                               isDonde: false,
                               endDate: "20.10.27"),
                RemindersModel(title: "Написать код", desc: "Сделать SwiftUI приложение",
                               date: "20.10.25",
                               isDonde: true,
                               endDate: "20.01.26")]
    }
}
