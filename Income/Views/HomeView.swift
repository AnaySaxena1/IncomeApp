//  HomeView.swift
//  Income
//
//  Created by Anay Saxena on 08/06/25.
//

import SwiftUI

struct HomeView: View {
    
    @State private var transactions: [Transaction] = []
    @State private var showAddTransactionView: Bool = false
    @State private var transactionToEdit: Transaction?
    @State private var showSettings = false
    
    @AppStorage("orderDescending") var orderDescending = false  // var inside app storage and normal variable should match
    @AppStorage("currency") var currency: Currency = .inr
    @AppStorage("FilterMinimum") private var filterMinium = 0.0
    private var displayTransaction: [Transaction] {
        let sortedTransactions = orderDescending ? transactions.sorted(by: { $0.date < $1.date})
        : transactions.sorted(by: {$0.date > $1.date })
        let filterTransactions = sortedTransactions.filter({$0.amount >= filterMinium   })
        return filterTransactions 
    }
    
    private  var expense: String{
        let sumExpenses = transactions.filter({ $0.type == .expense }).reduce(0,{$0 + $1.amount })
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.locale = currency.locale
        return numberFormatter.string(from: sumExpenses as NSNumber) ?? "$0.00"
    }
    private var income: String{
        let sumIncome = transactions.filter({ $0.type == .income }).reduce(0,{$0 + $1.amount })
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.locale = currency.locale
        return numberFormatter.string(from: sumIncome as NSNumber) ?? "$0.00"
    }
    private var total: String {
        let sumExpenses = transactions.filter({ $0.type == .expense }).reduce(0,{$0 + $1.amount })
        let sumIncome = transactions.filter({ $0.type == .income }).reduce(0,{$0 + $1.amount })
        let  total = sumIncome - sumExpenses
        let numberFormatter = NumberFormatter()
        numberFormatter.locale = currency.locale
        numberFormatter.numberStyle = .currency
        return numberFormatter.string(from: total as NSNumber) ?? "$0.00"
    }
    @State private var Balance: Double = 0
    fileprivate func FloatingBUtton() -> some View {
        VStack{
            Spacer()
            NavigationLink{
                AddTransactionView(transactions: $transactions)
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
                    VStack(alignment: .leading) {
                        Text("BALANCE")
                            .font(.caption)
                            .foregroundColor(.white)
                        Text("\(total)")
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
                        Text("\(expense)")
                            .font(.system(size:15, weight:.semibold))
                            .foregroundStyle(Color.white)
                    }
                    VStack(alignment:.leading){
                        Text("Income")
                            .font(.system(size:15,weight: .semibold))
                            .foregroundStyle(Color.white)
                        Text("\(income)")
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
                        ForEach(displayTransaction ) { transaction in
                            Button(action: {
                                transactionToEdit = transaction
                            }, label: {
                                TransactionView(transaction: transaction)
                                    .foregroundStyle(.black)
                            })
                        }
                        .onDelete(perform: delete)
                    }
                    .scrollContentBackground(.hidden)
                }
                FloatingBUtton()
            }
            .navigationTitle("Income")
            .navigationDestination(item: $transactionToEdit, destination: {
                transactionToEdit in
                AddTransactionView(transactionToEdit: transactionToEdit, transactions: $transactions)
            })
            .navigationDestination(isPresented: $showAddTransactionView,destination: {
                AddTransactionView(transactions: $transactions)
            })
            .sheet(isPresented: $showSettings, content: {
                SettingsView()
            })
            .toolbar{
                ToolbarItem(placement: .topBarTrailing){
                    Button(action: {
                        showSettings = true
                    },label: {
                        Image(systemName: "gearshape.fill")
                    })
                    
                }
            }
        }
    }
    private func delete(at offsets: IndexSet){
        transactions.remove(atOffsets: offsets)
    }
}
#Preview {
    HomeView()
}

