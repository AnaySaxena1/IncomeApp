//
//  HomeView.swift
//  Income
//
//  Created by Anay Saxena on 08/06/25.
//

import SwiftUI

struct HomeView: View {
    
    @State private var transactions: [Transaction] = [
        Transaction(title: "Apple", type:.expense,amount:5.959,date: Date()),
        Transaction(title: "Apple", type:.expense, amount:5.959,date: Date())
    ]
    fileprivate func FloatingBUtton() -> some View {
        VStack{
            Spacer()
            NavigationLink{
                AddTransactionView()
            } label: {
                Text("+")
                    .font(.largeTitle)
                    .frame(width:70, height: 70)
                    .foregroundStyle(Color.white)
                    .padding(.bottom,7)
            }
            .background(Color.primaryLightGreen)
            .clipShape(Circle())
        }
    }
    fileprivate func BalanceView() -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.primaryLightGreen)
            VStack(alignment: .leading,spacing:12){
                HStack{
                    VStack {
                        Text("BALANCE")
                            .font(.caption)
                            .foregroundColor(.white)
                        Text("$2")
                            .font(.system(size: 42,weight: .light))
                            .foregroundStyle(.white)
                    }
                    Spacer()
                }
                .padding(.top)
                
                HStack(spacing:25){
                    VStack(alignment: .leading){
                        Text("Expense")
                            .font(.system(size:15,weight: .semibold))
                            .foregroundStyle(Color.white)
                        Text("$20")
                            .font(.system(size:15, weight:.semibold))
                            .foregroundStyle(Color.white)
                    }
                    VStack(alignment:.leading){
                        Text("Income")
                            .font(.system(size:15,weight: .semibold))
                            .foregroundStyle(Color.white)
                        Text("$22")
                            .font(.system(size:15, weight:.semibold))
                            .foregroundStyle(Color.white)
                    }
                }
                Spacer()
            }
            .padding(.horizontal)
        }
        .shadow(color: Color.black.opacity(0.3), radius: 10, x: 0, y: 5)
        .frame(height: 150)
        .padding(.horizontal)
    }
    
    var body: some View {
        
        NavigationStack {
            ZStack {
                VStack {
                    BalanceView()
                    List{
                        ForEach(transactions) { transaction in
                            TransactionView(transaction: transaction)
                        }
                    }
                    .scrollContentBackground(.hidden)
                }
                FloatingBUtton()
            }
            .navigationTitle("Income")
            .toolbar{
                ToolbarItem(placement: .topBarTrailing){
                    Button(action: {
                        
                    },label: {
                        Image(systemName: "gearshape.fill")
                    })
                    
                }
            }
        }
    }
}
#Preview {
    HomeView()
}

