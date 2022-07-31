//
//  Transaction.swift
//  ASBInterviewExercise
//
//  Created by Chao on 31/07/22.
//

import Foundation

struct Transaction: Decodable {
    let id: Int
    let transactionDate: Date
    let summary: String
    let debit: Decimal
    let credit: Decimal
    
    var debitString: String? {
        return NumberFormatter.transactionDecimalFormatter().string(for: debit)
    }
    
    var creditString: String? {
        return NumberFormatter.transactionDecimalFormatter().string(for: credit)
    }
    
    var gstString: String? {
        return NumberFormatter.transactionDecimalFormatter().string(for: debit * 0.15)
    }
}
