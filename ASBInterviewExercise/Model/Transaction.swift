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
}
