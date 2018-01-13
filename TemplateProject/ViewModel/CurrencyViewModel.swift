//
//  CurrencyViewModel.swift
//  TemplateProject
//
//  Created by Benoit PASQUIER on 13/01/2018.
//  Copyright © 2018 Benoit PASQUIER. All rights reserved.
//

import Foundation

struct CurrencyViewModel {
    
    weak var dataSource : GenericDataSource<CurrencyRate>?
    
    let numberFormatter = NumberFormatter()
    var converter : Converter?
    var currency = Currency.GBP
    
    var task : URLSessionTask?
    
    init(dataSource : GenericDataSource<CurrencyRate>?) {
        self.dataSource = dataSource
        self.numberFormatter.numberStyle = .currency
    }
    
    func fetchCurrencies() {
        CurrencyService.shared.fetchConverter { result in
            
            DispatchQueue.main.async {
                switch result {
                case .success(let converter) :
                    // reload data
                    print("Parser success \(converter)")
//                    self.converter = converter
                    self.dataSource?.data.value = converter.rates
                    
                    break
                case .failure(let error) :
                    print("Parser error \(error)")
                    //                    self.converter = nil
                    break
                }
            }
        }
    }
}
