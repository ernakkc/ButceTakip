//
//  TransactionView.swift
//  ButceTakip
//
//  Created by Eren Akkoç on 30.07.2026.
//

import SwiftUI
import SwiftData

struct TransactionView: View {

    @State private var showPopup = false
    @Bindable var transaction: Transaction

    var body: some View {
        VStack(spacing: 6) {
            HStack {
                Text(transaction.title).fontWeight(.medium)
                Spacer()
                amountText
            }

            HStack {
                Text(transaction.note)
                    .font(.caption2)
                    .foregroundStyle(.secondary)
                    .lineLimit(1)
                Spacer()
            }
            Divider()
        }
        .contentShape(Rectangle())
        .onTapGesture {
            showPopup = true
        }
        .sheet(isPresented: $showPopup) {
            EditView(
                transaction: transaction,
                isPresented: $showPopup
            )
        }
    }

    private var amountText: some View {
        HStack(spacing: 3) {
            Text(transaction.transactionType == .EXPENSE ? "-" : "+")
            Text(transaction.amount.formatted(.number.precision(.fractionLength(2))))
            Text(transaction.currency.rawValue)
        }
        .fontWeight(.bold)
        .foregroundStyle(
            transaction.transactionType == .EXPENSE
                ? Color.red
                : Color.green
        )
    }
}


#Preview {
    let transaction = Transaction(
        title: "Salatalık",
        amount: 250,
        currency: .TL,
        note: "Market alışverişi",
        date: .now,
        time: .now,
        category: .FOOD,
        transactionType: .EXPENSE
    )

    TransactionView(transaction: transaction)
        .padding(20)
        .modelContainer(for: Transaction.self, inMemory: true)
}
