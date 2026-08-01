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


enum CurrencyType: String, Codable, CaseIterable, Identifiable{
    case TL
    case USD
    case EURO
    
    var id: Self { self }
}

enum CategoryType: String, Codable, CaseIterable, Identifiable{
    case FOOD
    case HOUSE
    case TRANSPORT
    case BANK
    case OTHER
    
    var id: Self { self }
}

enum TransactionType: String, Codable, CaseIterable, Identifiable{
    case INCOME
    case EXPENSE
    
    var id: Self { self }
}


