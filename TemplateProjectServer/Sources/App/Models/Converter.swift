//
//  Converter.swift
//  App
//
//  Created by Benoit PASQUIER on 28/04/2019.
//

import Vapor

struct CurrencyRate: Content {
    let eur: Double
    let usd: Double
    let gbp: Double
    let sgd: Double
    
    private enum CodingKeys: String, CodingKey {
        case eur = "EUR"
        case usd = "USD"
        case gbp = "GBP"
        case sgd = "SGD" 
    }
}

struct Converter: Content {
    
    let base : String
    let date : String
    let rates : CurrencyRate
}
