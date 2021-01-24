//
//  CurrencyViewModel.swift
//  TemplateProject
//
//  Created by Benoit PASQUIER on 13/01/2018.
//  Copyright © 2018 Benoit PASQUIER. All rights reserved.
//

import Foundation
import Combine

class CurrencyViewModel {
    
    weak private var service: CurrencyServicePublisher?
    let reload: PassthroughSubject<Void, Never>
    
    @Published private(set) var rates: [CurrencyRate]
    @Published private(set) var errorMessage: String?
    
    init(service: CurrencyServicePublisher = FileDataService()) {
        self.service = service
        
        rates = []
        reload = PassthroughSubject<Void, Never>()
        
        bindReloadToFetchConverter()
    }
    
    func bindReloadToFetchConverter() {
        reload.compactMap { [weak self] _ in 
            self?.service?.fetchConverter()
        }
        .switchToLatest()
        .subscribe(on: RunLoop.main)
        .map(\.rates)
        .catch({ [weak self] error -> Just<[CurrencyRate]> in
            print("Error", error)
            self?.errorMessage = (error as? ErrorResult)?.localizedDescription ?? error.localizedDescription
            return Just([CurrencyRate]())
        })
        .assign(to: &$rates)
    }
}
