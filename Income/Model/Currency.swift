//
//  Currency.swift
//  Income
//
//  Created by Anay Saxena on 22/06/25.
//

import Foundation

enum Currency: Int, CaseIterable{ // now can be used to iterate  (foreach loop)
    
    case usd,pounds,inr
    
    var title: String {
        switch self {
        case .inr:
            return "INR"
        case .usd:
            return "USD"
        case .pounds:
            return "Pounds"
        }
    }
    var locale: Locale {
        switch self {
            case.usd:
                return Locale(identifier: "en_US")
            case .pounds:
                return Locale(identifier: "en_GB")
            case .inr:
                return Locale(identifier: "hi_IN")
        }
    }
}
