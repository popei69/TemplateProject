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
    
    let endpoint = "https://api.fixer.io/latest?base=GBP"
    
//    let numberFormatter = NumberFormatter()
    
//    var converter : Converter?
//    var currency = Currency.GBP 
    
    var task : URLSessionTask?
    
    private override init() {
        super.init()
        
//        numberFormatter.numberStyle = .currency
    }
    
    func fetchConverter(_ completion: @escaping ((Result<Converter, ErrorResult>) -> Void)) {
        
        // cancel previous request if already in progress
        self.cancelFetchCurrencies()
        
        task = RequestService().loadData(urlString: endpoint, completion: self.networkResult(completion: completion))
    }
    
    func cancelFetchCurrencies() {
        
        if let task = task {
            task.cancel()
        }
        task = nil
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
}
