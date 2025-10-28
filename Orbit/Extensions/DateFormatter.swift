//
//  DateFormatter.swift
//  Orbit
//
//  Created by Евгений Овчинников on 28.10.2025.
//

import Foundation

final class DateFormatHelper {
    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = Constants.DateFormat.reminderDateFormat
        return formatter
    }()
    
    static func getString(from date: Date) -> String {
        dateFormatter.string(from: date)
    }
    
    static func getDate(from dateString: String) -> Date {
        dateFormatter.date(from: dateString) ?? Date()
    }
}
