//
//  DateUtil.swift
//  TravelManagePlanner
//
//  Created by UY on 2022/01/10.
//

import Foundation

class DateUtil {
    static func parseDate(_ dateString: String) -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.locale = Locale(identifier: "en_US_POSIX")

        return formatter.date(from: dateString) ?? Date()
    }

    static func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"

        return formatter.string(from: date)
    }

    static func dueString(start: Date, end: Date) -> String {
        return "\(formatDate(start)) ~ \(formatDate(end))"
    }
}
