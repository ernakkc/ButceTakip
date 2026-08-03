//
//  CategoryType.swift
//  ButceTakip
//
//  Created by Eren Akkoç on 3.08.2026.
//


enum CategoryType: String, Codable, CaseIterable, Identifiable{
    case FOOD
    case HOUSE
    case TRANSPORT
    case BANK
    case OTHER
    
    var id: Self { self }
}