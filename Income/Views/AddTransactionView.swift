//
//  AddTransactionView.swift
//  Income
//
//  Created by Anay Saxena on 08/06/25.
//

import SwiftUI

struct AddTransactionView: View {
    @State private var amount = 0.0
    @State private var transactionTitle: String = ""
    @State private var selectedTransactionType: TransactionType = .expense
    @State private var alertTitle: String = ""
    @State private var alertMessage: String = ""
    @State private var showAlert = false
    var transactionToEdit: Transaction?
    @Binding var transactions: [Transaction]
    @Environment(\.dismiss) var dismiss
    
    var numberFormatter: NumberFormatter{
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        return numberFormatter
    }
        
    var body: some View {
        VStack {
            TextField("0.00", value: $amount, formatter: numberFormatter)
                .font(.system(size:60,weight: .thin))
                .multilineTextAlignment(.center)
                .keyboardType(.numberPad)
            Rectangle()
                .fill(Color.lightGrayShade)
                .frame(height:0.5)
                .padding(.horizontal,30)
            Picker("Choose Transaction Type", selection: $selectedTransactionType) {
                ForEach(TransactionType.allCases) { transactionType in
                    Text(transactionType.title)
                        .tag(transactionType)
                }
            }
            TextField("Title",text: $transactionTitle)
                .font(.system(size:15))
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal,30)
                .padding(.top)
            Button(action: {
                guard transactionTitle.count >= 2 else {
                    alertTitle = "Invalid Titile"
                    alertMessage = "Title must be 2 or more characters long"
                    showAlert = true
                    return
                }
                
                let transaction = Transaction(title: transactionTitle,type: selectedTransactionType, amount: amount, date: Date())
                
                if let transactionToEdit = transactionToEdit {
                    guard let indexOfTransaction = transactions.firstIndex(of: transactionToEdit) else {
                        alertTitle = "Something went wrong"
                        alertMessage = "Cannot update this transaction right now."
                        showAlert = true
                        return
                    }
                    transactions[indexOfTransaction] = transaction
                } else {
                    transactions.append(transaction)
                }
                
                dismiss()
                
            }, label: {
                Text(transactionToEdit == nil ? "Create" : "Update")
                    .font(.system(size:15,weight: .semibold))
                    .foregroundStyle(.white)
                    .frame(height:40)
                    .frame(maxWidth: .infinity)
                    .background(Color.primaryLightGreen)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            })
            .padding(.top)
            .padding(.horizontal,30)
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
        .alert(alertTitle, isPresented: $showAlert){
            Button(action: {
                
            },label: {
                Text("OK")
            })
            
        } message: {
            Text(alertMessage)
        }
    }
}

#Preview {
    AddTransactionView(transactions: .constant([]))
}
