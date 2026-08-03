//
//  CurrencyType.swift
//  ButceTakip
//
//  Created by Eren Akkoç on 3.08.2026.
//


enum CurrencyType: String, Codable, CaseIterable, Identifiable{
    case TL
    case USD
    case EURO
    
    var id: Self { self }
}