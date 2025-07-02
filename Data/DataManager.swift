//
//  DataManager.swift
//  Income
//
//  Created by Anay Saxena on 02/07/25.
//

import Foundation
import CoreData

//Singleton
class DataManager {
    
    let container = NSPersistentContainer(name: "IncomeData")
    static let shared = DataManager() //as this in the class so we can make this DataManager
    
    init() { // no one will be able to intializer because of private
        container.loadPersistentStores { store, error in
            if let error = error as NSError? {
                print(error.localizedDescription)
            }
        }
    }
}

