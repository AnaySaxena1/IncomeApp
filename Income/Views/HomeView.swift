//  HomeView.swift
//  Income
//
//  Created by Anay Saxena on 08/06/25.
//
//
// CRUD
/*
 1. Object Graph Management
 2. Persistence Store Coordinator
 3. Persistence -> SQLite if user dismiss the app or restart but it will be not be deleted  afterwards but if app is delete all the data gets scrapped
 */
/*
 1. Persistence Container -> Entity (it contains all the entity)
 2. DataManager  -> Managed Object Context
 3. Create
 4. Read -> will be using FetechRequest
 5. Update
 6. Delete
 7. In Memory Persistence
 */
import SwiftUI
import SwiftData

struct HomeView: View {
    
    //@State private var transactions: [Transaction] = []
    
    @Query var transactions: [TransactionModel] = []
    
    @State private var showAddTransactionView = false
    @State private var transactionToEdit: TransactionModel?
    
    @State private var showSettings = false
    
    @Environment(\.modelContext) private var context
    
    @AppStorage("orderDescending") var orderDescending = false
    @AppStorage("filterMinimum") var filterMinimum = 0.0
    @AppStorage("currency") var currency = Currency.usd
    
    private var numberFormatter: NumberFormatter {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.locale = currency.locale
        return numberFormatter
    }
    
    private var displayTransactions: [TransactionModel] {
        let sortedTransactions = orderDescending ? transactions.sorted(by: { $0.date < $1.date }) : transactions.sorted(by: { $0.date > $1.date })
        guard filterMinimum > 0 else {
            return sortedTransactions
        }
        let filteredTransactions = sortedTransactions.filter({ $0.amount > filterMinimum })
        return filteredTransactions
    }
    
    private var expenses: String {
        let sumExpenses = transactions.filter({ $0.type == .expense }).reduce(0, { $0 + $1.amount })
        return numberFormatter.string(from: sumExpenses as NSNumber) ?? "$US0.00"
    }
    
    private var income: String {
        let sumIncome = transactions.filter({ $0.type == .income }).reduce(0, { $0 + $1.amount })
        return numberFormatter.string(from: sumIncome as NSNumber) ?? "$US0.00"
    }
    
    private var total: String {
        let sumExpenses = transactions.filter({ $0.type == .expense }).reduce(0, { $0 + $1.amount })
        let sumIncome = transactions.filter({ $0.type == .income }).reduce(0, { $0 + $1.amount })
        let total = sumIncome - sumExpenses
        return numberFormatter.string(from: total as NSNumber) ?? "$US0.00"
    }
    
    fileprivate func FloatingButton() -> some View {
        VStack {
            Spacer()
            NavigationLink {
                AddTransactionView()
            } label: {
                Text("+")
                    .font(.largeTitle)
                    .frame(width: 70, height: 70)
                    .foregroundStyle(Color.white)
                    .padding(.bottom, 7)
                    
            }
            .background(Color.primaryLightGreen)
            .clipShape(Circle())
        }
    }
    
    fileprivate func BalanceView() -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.primaryLightGreen)
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    VStack(alignment: .leading) {
                        Text("BALANCE")
                            .font(.caption)
                            .foregroundStyle(Color.white)
                        Text("\(total)")
                            .font(.system(size: 42, weight: .light))
                            .foregroundStyle(Color.white)
                    }
                    Spacer()
                }
                .padding(.top)
                
                HStack(spacing: 25) {
                    VStack(alignment: .leading) {
                        Text("Expense")
                            .font(.system(size: 15, weight: .semibold))
                            .foregroundStyle(Color.white)
                        Text("\(expenses)")
                            .font(.system(size: 15, weight: .regular))
                            .foregroundStyle(Color.white)
                    }
                    VStack(alignment: .leading) {
                        Text("Income")
                            .font(.system(size: 15, weight: .semibold))
                            .foregroundStyle(Color.white)
                        Text("\(income)")
                            .font(.system(size: 15, weight: .regular))
                            .foregroundStyle(Color.white)
                    }
                }
                Spacer()
            }
            .padding(.horizontal)
        }
        .shadow(color: Color.black.opacity(0.3), radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/, x: 0, y: 5)
        .frame(height: 150)
        .padding(.horizontal)
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    BalanceView()
                    List {
                        ForEach(displayTransactions) { transaction in
//                            TransactionView(transaction: transaction)
//                                .foregroundStyle(.black)
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
                FloatingButton()
            }
            .sheet(isPresented: $showSettings, content: {
                SettingsView()
            })
            .navigationTitle("Income")
            .navigationDestination(item: $transactionToEdit, destination: { transactionToEdit in
                AddTransactionView(transactionToEdit: transactionToEdit)
            })
            .navigationDestination(isPresented: $showAddTransactionView, destination: {
                AddTransactionView()
            })
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        showSettings = true
                    }, label: {
                        Image(systemName: "gearshape.fill")
                            .foregroundStyle(Color.black)
                    })
                }
            }
        }
    }
    
    private func delete(at offsets: IndexSet) {
        for index in offsets {
            context.delete(transactions[index])
            try? context.save()
        }
    }
    
}

#Preview {
    let previewContainer = PreviewHelper.previewContainer
    return HomeView()
        .modelContainer(previewContainer)
}


