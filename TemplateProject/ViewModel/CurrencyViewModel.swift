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
    weak var service: CurrencyServiceProtocol?
    
    var onErrorHandling : ((ErrorResult?) -> Void)?
    
    init(service: CurrencyServiceProtocol = FileDataService.shared, dataSource : GenericDataSource<CurrencyRate>?) {
        self.dataSource = dataSource
        self.service = service
    }
    
    func fetchCurrencies() {
        
        guard let service = service else {
            onErrorHandling?(ErrorResult.custom(string: "Missing service"))
            return
        }
        
        service.fetchConverter { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let converter) :
                    self.dataSource?.data.value = converter.rates
                case .failure(let error) :
                    self.onErrorHandling?(error)
                }
            }
        }
    }
}
