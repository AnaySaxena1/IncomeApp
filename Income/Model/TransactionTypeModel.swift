//
//  TransactionType.swift
//  Income
//
//  Created by Anay Saxena on 08/06/25.
//

import Foundation

enum TransactionType: Int, CaseIterable, Identifiable, Codable {
    case income = 0 , expense
    var id: Self { self }
    
    var title: String {
        switch self {
        case .income:
            return "Income"
        case .expense:
            return "Expense"
        }
    }
}
