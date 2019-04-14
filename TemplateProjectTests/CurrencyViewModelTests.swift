//
//  CurrencyViewModelTests.swift
//  TemplateProjectTests
//
//  Created by Benoit Pasquier on 31/01/2018.
//  Copyright © 2018 Benoit PASQUIER. All rights reserved.
//

import XCTest
import RxSwift
import RxTest
import RxBlocking
@testable import TemplateProject

class CurrencyViewModelTests: XCTestCase {
    
    var viewModel : CurrencyViewModel!
    var scheduler: TestScheduler!
    var disposeBag: DisposeBag!
    
    fileprivate var service : MockCurrencyService!
    
    override func setUp() {
        super.setUp()
        self.scheduler = TestScheduler(initialClock: 0)
        self.disposeBag = DisposeBag()
        self.service = MockCurrencyService()
        self.viewModel = CurrencyViewModel(service: service)
    }
    
    override func tearDown() {
        self.viewModel = nil
        self.service = nil
        super.tearDown()
    }
    
    func testFetchWithError() {
        
        // create scheduler
        let rates = scheduler.createObserver([CurrencyRate].self)
        let errorMessage = scheduler.createObserver(String.self)
        
        // giving a service with no currencies
        service.converter = nil
        
        viewModel.output.errorMessage
            .drive(errorMessage)
            .disposed(by: disposeBag)
        
        viewModel.output.rates
            .drive(rates)
            .disposed(by: disposeBag)
        
        scheduler.createColdObservable([.next(10, ())])
            .bind(to: viewModel.input.reload)
            .disposed(by: disposeBag)
        scheduler.start()
        
        XCTAssertEqual(errorMessage.events, [.next(10, "No converter")])
    }
    
    func testFetchWithNoCurrency() {
        
        // create scheduler
        let rates = scheduler.createObserver([CurrencyRate].self)
        
        // giving a service with no currencies
        service.converter = nil
        
        viewModel.output.rates
            .drive(rates)
            .disposed(by: disposeBag)
        
        scheduler.createColdObservable([.next(10, ())])
            .bind(to: viewModel.input.reload)
            .disposed(by: disposeBag)
        scheduler.start()
        
        XCTAssertEqual(rates.events, [.next(10, []), .completed(10)])
    }
    
    func testFetchCurrencies() {
        
        // create scheduler
        let rates = scheduler.createObserver([CurrencyRate].self)
        
        // giving a service mocking currencies
        let expectedRates: [CurrencyRate] = [CurrencyRate(currencyIso: "USD", rate: 1.4)]
        service.converter = Converter(base: "GBP", date: "01-01-2018", rates: expectedRates)

        // bind the result
        viewModel.output.rates
            .drive(rates)
            .disposed(by: disposeBag)
        
        // mock a reload
        scheduler.createColdObservable([.next(10, ()), .next(30, ())])
            .bind(to: viewModel.input.reload)
            .disposed(by: disposeBag)
        
        scheduler.start()
        
        XCTAssertEqual(rates.events, [.next(10, expectedRates), .next(30, expectedRates)])
    }
}

fileprivate class MockCurrencyService: CurrencyServiceProtocol, CurrencyServiceObservable {
    
    var converter : Converter?

    func fetchConverter(_ completion: @escaping ((Result<Converter, ErrorResult>) -> Void)) {

        if let converter = converter {
            completion(Result.success(converter))
        } else {
            completion(Result.failure(ErrorResult.custom(string: "No converter")))
        }
    }
    
    func fetchConverter() -> Observable<Converter> {
        if let converter = converter {
            return Observable.just(converter)
        } else {
            return Observable.error(ErrorResult.custom(string: "No converter"))
        }
    }
}
