//
//  TransactionalModel.swift
//  Income
//
//  Created by Anay Saxena on 08/06/25.
//

import Foundation
import SwiftUI
import SwiftData

/*
 @Model is called a Macro and this is reponsible for making a class persistable.
 It makes a model schema.
 */

@Model class TransactionModel {
    
    var  id: UUID
    var title: String
    var type: TransactionType
    var amount: Double
    var date: Date
    
    init(id: UUID, title: String, type: TransactionType, amount: Double, date: Date) {
        self.id = id
        self.title = title
        self.type = type
        self.amount = amount
        self.date = date
    }
    
    var displayDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        return dateFormatter.string(from: date)
    }
    
    func display(currency: Currency) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.locale = currency.locale
        return numberFormatter.string(from: amount as NSNumber) ?? ""
    }
    
}

struct Transaction: Identifiable {
    
    let id = UUID()
    let title: String
    let type: TransactionType
    let amount: Double
    let date: Date
    
    var displayDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        return dateFormatter.string(from: date)
    }
    
    func display(currency: Currency) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.locale = currency.locale
        return numberFormatter.string(from: amount as NSNumber) ?? ""
    }
    
}

extension Transaction: Hashable {
    
    static func == (lhs: Transaction, rhs: Transaction) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
