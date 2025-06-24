//
//  Date+Ext.swift
//  GHFollowers
//
//  Created by Igor Cotrim on 24/06/25.
//

import Foundation

extension Date {
    func convertToMonthYearFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM yyyy"
        return dateFormatter.string(from: self)
    }
}
