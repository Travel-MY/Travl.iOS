//
//  DateFormatterExtensions.swift
//  Travl.iOS
//
//  Created by Ikmal Azman on 16/12/2021.
//

import Foundation

extension DateFormatter {
    func convertStringToDate(_ date : String) -> Date {
        self.timeStyle = .none
        self.dateStyle = .medium
        let convertedString = self.date(from: date)!
        return convertedString
    }
    
    func convertDateToString(_ date : Date) -> String {
        self.timeStyle = .none
        self.dateStyle = .medium
        let convertedDate = self.string(from: date)
        return convertedDate
    }
}
