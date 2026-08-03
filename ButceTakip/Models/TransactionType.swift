//
//  TransactionType.swift
//  ButceTakip
//
//  Created by Eren Akkoç on 3.08.2026.
//


enum TransactionType: String, Codable, CaseIterable, Identifiable{
    case INCOME
    case EXPENSE
    
    var id: Self { self }
}