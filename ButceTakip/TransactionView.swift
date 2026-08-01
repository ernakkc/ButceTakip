//
//  TransactionView.swift
//  ButceTakip
//
//  Created by Eren Akkoç on 30.07.2026.
//


import SwiftUI
import _SwiftData_SwiftUI

struct TransactionView: View {
    var transaction: Transaction
    init(transaction: Transaction) {
        self.transaction = transaction
    }
    
    
    var body: some View {
        VStack {
            HStack {
                Text(transaction.title)
                Spacer()
                if (transaction.transactionType == .EXPENSE) {
                    Text("- \(transaction.amount.formatted(.number.precision(.fractionLength(2)))) ₺").fontWeight(.bold).foregroundColor(.red)
                } else {
                    Text("\(transaction.amount.formatted(.number.precision(.fractionLength(2)))) ₺").fontWeight(.bold).foregroundColor(.green)
                }
                
            }
            HStack{ Text(transaction.note).font(.caption2).foregroundColor(.secondary) ; Spacer()}
            Divider()
        }
        
    }
}

#Preview {
    var transaction: Transaction = Transaction(title: "Salatalık", amount: 250, currency: .TL, note: "Aldim götüme sokacam", date: .now, time: .now, category: .FOOD, transactionType: .EXPENSE)
    TransactionView(transaction: transaction).padding(20)
}
    
