//
//  AddTransactionView.swift
//  Income
//
//  Created by Anay Saxena on 08/06/25.
//

import SwiftUI

struct AddTransactionView: View {
    @State private var amount = 0.0
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
            Spacer()
        }
    }
}

#Preview {
    AddTransactionView()
}
