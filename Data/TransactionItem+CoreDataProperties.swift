//
//  TransactionItem+CoreDataProperties.swift
//  Income
//
//  Created by Anay Saxena on 02/07/25.
//
//

import Foundation
import CoreData


extension TransactionItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TransactionItem> {
        return NSFetchRequest<TransactionItem>(entityName: "TransactionItem")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var title: String?
    @NSManaged public var type: Int
    @NSManaged public var amount: Double
    @NSManaged public var date: Date?

}

extension TransactionItem : Identifiable {
    
}

extension TransactionItem{
    
    var wrappedId: UUID {
        return id!
    }
    
    var wrappedTitle: String {
        return title ?? ""
    }
    var wrappedDate: Date {
        return date ?? Date()
    }
    
    var wrappedTransactionType: TransactionType {
        return TransactionType(rawValue: (type)) ?? .expense
    }

    var wrappedAmount: Double {
        return amount
    }
}
