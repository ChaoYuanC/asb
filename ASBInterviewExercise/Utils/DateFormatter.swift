//
//  DateFormatter.swift
//  ASBInterviewExercise
//
//  Created by Charles on 31/07/22.
//

import Foundation

extension DateFormatter {
    static func transactionDateFormatter() -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateFormatter
    }
}
