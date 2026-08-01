//
//  Utils.swift
//  ButceTakip
//
//  Created by Eren Akkoç on 28.07.2026.
//

import Foundation
import SwiftUI

func totalIncoming(transactions: [Transaction]) -> Double {
    var sum = 0.0
    for transaction in transactions {
        if transaction.transactionType == .INCOME {sum+=transaction.amount}
    }
    return sum
}

func totalExpenses(transactions: [Transaction]) -> Double {
    var sum = 0.0
    for transaction in transactions {
        if transaction.transactionType == .EXPENSE {
            sum += transaction.amount
        }
    }
    return sum
}

var amountFormatter: NumberFormatter {
    let f = NumberFormatter()
    f.numberStyle = .decimal
    f.maximumFractionDigits = 2
    f.minimumFractionDigits = 0
    return f
}
