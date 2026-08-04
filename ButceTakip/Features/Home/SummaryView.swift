//
//  SummaryView.swift
//  ButceTakip
//
//  Created by Eren Akkoç on 29.07.2026.
//

import SwiftUI
import _SwiftData_SwiftUI

struct SummaryView: View {
    @Query(sort: \Transaction.date, order: .reverse) private var transactions: [Transaction]
    
    var totalIncome: Double {
        totalIncoming(transactions: transactions)
    }
    var totalExpense: Double {
        totalExpenses(transactions: transactions)
    }
    var budget: Double {
        totalIncome - totalExpense
    }
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("TRY").fontWeight(.bold)
            Text("\(budget.formatted(.number.precision(.fractionLength(2)))) ₺")
                .font(.largeTitle)
                .frame(maxWidth: .infinity, alignment: .leading)
                .fontWidth(.expanded)
            
            HStack {
                VStack {
                    Text("GELİR").font(.footnote).fontWeight(.bold)
                        .foregroundColor(.secondary)
                        .fontWidth(.condensed)
                    Text("\(totalIncome.formatted(.number.precision(.fractionLength(2)))) ₺").fontWeight(.bold)
                }
                Spacer()
                Rectangle().fill(Color.secondary).frame(width: 0.5, height: 20)
                Spacer()
                VStack {
                    Text("HARCAMA").font(.footnote).fontWeight(.bold)
                        .foregroundColor(.secondary)
                        .fontWidth(.condensed)
                    Text("\(totalExpense.formatted(.number.precision(.fractionLength(2)))) ₺").fontWeight(.bold)
                }
                
            }
        }
        .padding(25)
        .frame(maxWidth: .infinity)
        .background(Color(.gray).opacity(0.1))

        
    }
}

