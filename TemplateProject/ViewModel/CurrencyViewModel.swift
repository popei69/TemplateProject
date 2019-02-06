//
//  CurrencyViewModel.swift
//  TemplateProject
//
//  Created by Benoit PASQUIER on 13/01/2018.
//  Copyright © 2018 Benoit PASQUIER. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

struct CurrencyViewModel {
    
    weak var service: CurrencyServiceObservable?
    
    // outputs
    let rates : Observable<[CurrencyRate]>
    
    init(service: CurrencyServiceObservable = FileDataService.shared) {
        self.service = service
        
        rates = service.fetchConverter()
            .map({ $0.rates })
    }
}
