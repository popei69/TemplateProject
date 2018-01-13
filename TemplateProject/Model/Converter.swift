//
//  Converter.swift
//  TemplateProject
//
//  Created by Benoit PASQUIER on 13/01/2018.
//  Copyright © 2018 Benoit PASQUIER. All rights reserved.
//

import Foundation

struct Converter {
    
    let base : Currency
    let date : String
    
    let rates : [CurrencyRate]
}

extension Converter : Parceable {
    
    static func parseObject(dictionary: [String : AnyObject]) -> Result<Converter, ErrorResult> {
        if let base = dictionary["base"] as? String,
            let currency = Currency(rawValue: base),
            let date = dictionary["date"] as? String,
            let rates = dictionary["rates"] as? [String: Double] {
            
            var finalRates : [CurrencyRate] = []
            for (currencyIso, value) in rates {
//                if let currency = Currency(rawValue: currencyIso) {
                    finalRates.append(CurrencyRate(currency: currencyIso, rate: value))
//                }
            }
            
            let conversion = Converter(base: currency, date: date, rates: finalRates)
            
            return Result.success(conversion)
        } else {
            return Result.failure(ErrorResult.parser(string: "Unable to parse conversion rate"))
        }
    }
}
