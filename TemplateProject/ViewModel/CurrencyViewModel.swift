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

    let input: Input
    let output: Output
    
    struct Input {
        let reload: PublishRelay<Void>
    }
    
    struct Output {
        let rates: Driver<[CurrencyRate]>
        let errorMessage: Driver<String>
    }
    
    init(service: CurrencyServiceObservable = FileDataService.shared) {
        self.service = service
        
        let errorRelay = PublishRelay<String>()
        let reloadRelay = PublishRelay<Void>()
        
        let rates = reloadRelay
            .asObservable()
            .flatMapLatest({ service.fetchConverter() })
            .map({ $0.rates })
            .asDriver { (error) -> Driver<[CurrencyRate]> in
                errorRelay.accept((error as? ErrorResult)?.localizedDescription ?? error.localizedDescription)
                return Driver.just([])
            }
        
        
        self.input = Input(reload: reloadRelay)
        self.output = Output(rates: rates, 
                             errorMessage: errorRelay.asDriver(onErrorJustReturn: "An error happened"))
    }
}
