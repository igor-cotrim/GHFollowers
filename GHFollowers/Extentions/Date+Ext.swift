//
//  Date+Ext.swift
//  GHFollowers
//
//  Created by Igor Cotrim on 24/06/25.
//

import Foundation

extension Date {
    func convertToMonthYearFormat() -> String {
        return formatted(.dateTime.month().year())
    }
}
