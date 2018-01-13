//
//  CurrencyService.swift
//  TemplateProject
//
//  Created by Benoit PASQUIER on 13/01/2018.
//  Copyright © 2018 Benoit PASQUIER. All rights reserved.
//

import Foundation

final class CurrencyService : RequestHandler {
    
    static let shared = CurrencyService()
    
    let endpoint = "http://api.fixer.io/latest?base=GBP"
    
    let numberFormatter = NumberFormatter()
    
    var converter : Converter?
    var currency = Currency.GBP 
    
    private override init() {
        super.init()
        
        numberFormatter.numberStyle = .currency
    }
    
    func fetchConverter() {
        let _ = RequestService().loadData(urlString: endpoint, completion: self.networkResult(completion: self.parser))
    }
    
//    func convert(price: Price) -> Price {
//        
//        guard price.currencyIso != currency.rawValue else {
//            return price
//        }
//        
//        let currencyRate = converter?.rates.first { $0.currency == currency }
//        let currencyLocale = self.local(currency: currency)
//        
//        if let currencyRate = currencyRate {
//            numberFormatter.locale = Locale(identifier: currencyLocale.rawValue)
//            
//            let newValue = round(price.value * currencyRate.rate)
//            let formattedValue = numberFormatter.string(from: newValue as NSNumber) ?? ""
//            return Price(value: newValue, currencyIso: currency.rawValue, formattedValue: formattedValue)
//        }
//        
//        return price
//    }
    
    var parser : ((Result<Converter, ErrorResult>) -> Void) {
        return { postsResult in 
            
            DispatchQueue.main.async {
                switch postsResult {
                case .success(let converter) :
                    // reload data
                    print("Parser success \(converter)")
                    self.converter = converter
                    break
                case .failure(let error) :
                    print("Parser error \(error)")
                    self.converter = nil
                    break
                }
            }
            
        }
    }
}
