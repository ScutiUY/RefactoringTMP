//
//  String+extension.swift
//  TravelManagePlanner
//
//  Created by UY on 2022/02/13.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, tableName: "Localizable", value: self, comment: "")
    }
    
    func localizedFormat(_ arguments: CVarArg...) -> String {
        let localizedValue = self.localized
        return String(format: localizedValue, arguments: arguments)
    }
}
