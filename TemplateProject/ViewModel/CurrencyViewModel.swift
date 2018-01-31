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
    
    init(service: CurrencyServiceProtocol = CurrencyService.shared, dataSource : GenericDataSource<CurrencyRate>?) {
        self.dataSource = dataSource
        self.service = service
    }
    
    func fetchCurrencies(_ completion: ((Result<Bool, ErrorResult>) -> Void)? = nil) {
        
        guard let service = service else {
            completion?(Result.failure(ErrorResult.custom(string: "Missing service")))
            return
        }
        
        service.fetchConverter { result in
            
            DispatchQueue.main.async {
                switch result {
                case .success(let converter) :
                    // reload data
                    self.dataSource?.data.value = converter.rates
                    completion?(Result.success(true))
                    
                    break
                case .failure(let error) :
                    print("Parser error \(error)")
                    completion?(Result.failure(error))
                    
                    break
                }
            }
        }
    }
}
