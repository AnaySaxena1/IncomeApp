//
//  HomeView.swift
//  Income
//
//  Created by Anay Saxena on 08/06/25.
//

import SwiftUI

struct HomeView: View {
    
    @State private var transactions: [Transaction] = [
        Transaction(title: "Apple",
                     type:.expense,
                    amount:5.959,
                    date: Date()),
        Transaction(title: "Apple",
                     type:.expense,
                    amount:5.959,
                    date: Date())
    ]
    
    var body: some View {
        VStack {
            List{
                ForEach(transactions) { transaction in
                    TransactionView(transaction: transaction)
                }
            }
            .scrollContentBackground(.hidden)
        }
        .padding()
    }
}

#Preview {
    HomeView()
}

