//
//  NumberFormatter.swift
//  ASBInterviewExercise
//
//  Created by Chao on 31/07/22.
//

import Foundation

extension NumberFormatter {
    static func transactionDecimalFormatter() -> NumberFormatter {
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        formatter.currencyCode = "NZD"
        formatter.numberStyle = .currency
        return formatter
    }
}
