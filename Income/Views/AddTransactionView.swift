//
//  AddTransactionView.swift
//  Income
//
//  Created by Anay Saxena on 08/06/25.
//

import SwiftUI

struct AddTransactionView: View {
    @State private var amount = 0.0
    @State private var transactionTitle = ""
    @State private var selectedTransactionType: TransactionType = .expense
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showAlert = false
    //@Binding var transactions: [Transaction]
    var transactionToEdit: TransactionModel?
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) private var context
    @AppStorage("currency") var currency = Currency.inr
    
    var numberFormatter: NumberFormatter {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.locale = currency.locale
        return numberFormatter
    }
    
    var body: some View {
        VStack {
            TextField("0.00", value: $amount, formatter: numberFormatter)
                .font(.system(size: 60, weight: .thin))
                .multilineTextAlignment(.center)
                .keyboardType(.numberPad)
            Rectangle()
                .fill(Color(uiColor: UIColor.lightGray))
                .frame(height: 0.5)
                .padding(.horizontal, 30)
            Picker("Choose Type", selection: $selectedTransactionType) {
                ForEach(TransactionType.allCases) { transactionType in
                    Text(transactionType.title)
                        .tag(transactionType)
                }
            }
            TextField("Title", text: $transactionTitle)
                .font(.system(size: 15))
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal, 30)
                .padding(.top)
            Button(action: {
                guard transactionTitle.count >= 2 else {
                    alertTitle = "Invalid Title"
                    alertMessage = "Title must be 2 or more characters long."
                    showAlert = true
                    return
                }
                //correction here. When editing the last date should be used
//                let transaction = Transaction(title: transactionTitle, type: selectedTransactionType, amount: amount, date: Date())
                
//                if let transactionToEdit = transactionToEdit {
//                    guard let indexOfTransaction = transactions.firstIndex(of: transactionToEdit) else {
//                        alertTitle = "Something went wrong"
//                        alertMessage = "Cannot update this transaction right now."
//                        showAlert = true
//                        return
//                    }
//                    let transaction = Transaction(title: transactionTitle, type: selectedTransactionType, amount: amount, date: transactionToEdit.date)
//                    transactions[indexOfTransaction] = transaction
//                } else {
//                    let transaction = Transaction(title: transactionTitle, type: selectedTransactionType, amount: amount, date: Date())
//                    transactions.append(transaction)
//                }
                
                //adding a transaction
                
                if let transactionToEdit = transactionToEdit {
                    transactionToEdit.title = transactionTitle
                    transactionToEdit.type = selectedTransactionType
                    transactionToEdit.amount = amount
                } else {
                    let transaction = TransactionModel(id: UUID(), title: transactionTitle, type: selectedTransactionType, amount: amount, date: Date())
                    context.insert(transaction)
                }
                
                dismiss()
                
            }, label: {
                Text(transactionToEdit == nil ? "Create" : "Update")
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundStyle(Color.white)
                    .frame(height: 40)
                    .frame(maxWidth: .infinity)
                    .background(Color.primaryLightGreen)
                    .clipShape(RoundedRectangle(cornerRadius: 6))
                    
            })
            .padding(.top)
            .padding(.horizontal, 30)
            Spacer()
        }
        .onAppear(perform: {
            if let transactionToEdit = transactionToEdit {
                amount = transactionToEdit.amount
                transactionTitle = transactionToEdit.title
                selectedTransactionType = transactionToEdit.type
            }
        })
        .padding(.top)
        .alert(alertTitle, isPresented: $showAlert) {
            Button(action: {
                
            }, label: {
                Text("OK")
            })
        } message: {
            Text(alertMessage)
        }

    }
}

#Preview {
    let previewContainer = PreviewHelper.previewContainer
    return AddTransactionView()
        .modelContainer(previewContainer)
}
