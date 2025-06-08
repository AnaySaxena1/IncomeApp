//
//  TransactionalModel.swift
//  Income
//
//  Created by Anay Saxena on 08/06/25.
//

import Foundation

struct Transaction:Identifiable{
    
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
    

}
