//
//  PreviewHelper.swift
//  Income
//
//  Created by Anay Saxena on 02/07/25.
//


import Foundation
import SwiftData

@MainActor
class PreviewHelper {
    
    static let previewContainer: ModelContainer = {
        do {
            let config = ModelConfiguration(isStoredInMemoryOnly: true)
            let container = try ModelContainer(for: TransactionModel.self, configurations: config)

            let transaction = TransactionModel(id: UUID(), title: "Lunch", type: .expense, amount: 5, date: Date())
            container.mainContext.insert(transaction)

            return container
        } catch {
            fatalError("Failed to create model container for previewing: \(error.localizedDescription)")
        }
    }()
    
}

