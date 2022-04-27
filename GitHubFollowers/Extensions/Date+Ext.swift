//
//  Date+Ext.swift
//  GitHubFollowers
//
//  Created by Abdullah Al Sohel on 4/22/22.
//

import Foundation

extension Date {
    func convertToDayMonthYear() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy"
        return dateFormatter.string(from: self)
    }
}
