//
//  IncomeApp.swift
//  Income
//
//  Created by Anay Saxena on 08/06/25.
//

import SwiftUI
import SwiftData

/*
 The model container is responsible for storing the provided model schema types.
 These are the classes we marked with @Model macro.
 This also creates a model context which is responsible for observing changes to your models and
 saving, fetching and undoing changes.
 
 A note on Macros:
 A macro and a property wrapper look the same but a macro is executed at compile time whereas a
 property wrapper is executed at run time. A macro really just adds code where it is marked.
 */

@main
struct IncomeApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView()
                .modelContainer(for: [
                    TransactionModel.self
                ])
        }
    }
}
