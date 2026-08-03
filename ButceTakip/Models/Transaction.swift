//
//  Transaction.swift
//  ButceTakip
//
//  Created by Eren Akkoç on 28.07.2026.
//

import Foundation
import SwiftData

@Model
class Transaction {
    var uuid: UUID =  UUID()
    var title: String
    var amount: Double
    var currency: CurrencyType
    var note: String
    var date: Date
    var time: Date
    var category: CategoryType
    var transactionType: TransactionType
    
    init(title: String, amount: Double, currency: CurrencyType, note: String, date: Date, time: Date, category: CategoryType, transactionType: TransactionType) {
        self.title = title
        self.amount = amount
        self.currency = currency
        self.note = note
        self.date = date
        self.time = time
        self.category = category
        self.transactionType = transactionType
    }
}





