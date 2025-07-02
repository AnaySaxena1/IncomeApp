//
//  SettingsView.swift
//  Income
//
//  Created by Anay Saxena on 22/06/25.
//

import SwiftUI

struct SettingsView: View {
    
    @AppStorage("orderDescending")  var orderDescending = false // var inside app storage and normal variable should match
    @AppStorage("currency") private var currency: Currency = .inr
    @AppStorage("FilterMinimum") private var filterMinium = 0.0
    
    var numberFormatter: NumberFormatter {
        let numberformatter = NumberFormatter()
        numberformatter.numberStyle = .currency
        numberformatter.locale = currency.locale
        return numberformatter
    }
    
    var body: some View {
        NavigationStack {
            List{
                HStack{
                    Toggle(isOn: $orderDescending, label: {
                        Text("Order \(orderDescending ? "(Earliest)" : "(Latest)")")
                    })
                }
                HStack{
                    Picker("Currency",selection: $currency){
                        ForEach(Currency.allCases,id: \.self){
                            currency in
                            Text(currency.title)
                        }
                    }
                }
                HStack{
                    Text("Filter Minimum")
                    TextField("",value: $filterMinium,formatter: numberFormatter)
                        .multilineTextAlignment(.trailing)
                }
            }
            .navigationTitle(Text("Settings"))
        }
    }
}

#Preview {
    SettingsView()
}
