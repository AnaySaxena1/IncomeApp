//
//  TransactionalModel.swift
//  Income
//
//  Created by Anay Saxena on 08/06/25.
//

import Foundation
import SwiftUI

struct Transaction:Identifiable,Hashable{
    
    let id = UUID()
    let title:String
    let type:TransactionType
    let amount:Double
    let date:Date
    
    
    var displayDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        return dateFormatter.string(from: date)
    }
    
    func displayAmount(currency: Currency) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.locale =  currency.locale
        return numberFormatter.string(from: amount as  NSNumber) ?? "0.00"
    }
}
