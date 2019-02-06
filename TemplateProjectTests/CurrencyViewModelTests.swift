//
//  CurrencyViewModelTests.swift
//  TemplateProjectTests
//
//  Created by Benoit Pasquier on 31/01/2018.
//  Copyright © 2018 Benoit PASQUIER. All rights reserved.
//

import XCTest
@testable import TemplateProject

class CurrencyViewModelTests: XCTestCase {
    
    var viewModel : CurrencyViewModel!
    var dataSource : GenericDataSource<CurrencyRate>!
    fileprivate var service : MockCurrencyService!
    
    override func setUp() {
        super.setUp()
        self.service = MockCurrencyService()
        self.dataSource = GenericDataSource<CurrencyRate>()
        self.viewModel = CurrencyViewModel(service: service, dataSource: dataSource)
    }
    
    override func tearDown() {
        self.viewModel = nil
        self.dataSource = nil
        self.service = nil
        super.tearDown()
    }
    
    func testFetchWithNoService() {
        
        let expectation = XCTestExpectation(description: "No service currency")
        
        // giving no service to a view model
        viewModel.service = nil
        
        // expected to not be able to fetch currencies
        viewModel.onErrorHandling = { error in 
            expectation.fulfill()
        }
        
        viewModel.fetchCurrencies()
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testFetchCurrencies() {
        
        let expectation = XCTestExpectation(description: "Currency fetch")
        
        // giving a service mocking currencies
        service.converter = Converter(base: "GBP", date: "01-01-2018", rates: [])
        
        viewModel.onErrorHandling = { _ in
            XCTAssert(false, "ViewModel should not be able to fetch without service")
        }
        
        dataSource.data.addObserver(self) { _ in
            expectation.fulfill()
        }
        
        viewModel.fetchCurrencies()
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testFetchNoCurrencies() {
        
        let expectation = XCTestExpectation(description: "No currency")
        
        // giving a service mocking error during fetching currencies
        service.converter = nil
        
        // expected completion to fail
        viewModel.onErrorHandling = { error in 
            expectation.fulfill()
        }
        
        viewModel.fetchCurrencies()
        wait(for: [expectation], timeout: 5.0)
    }
}

fileprivate class MockCurrencyService : CurrencyServiceProtocol {
    
    var converter : Converter?

    func fetchConverter(_ completion: @escaping ((Result<Converter, ErrorResult>) -> Void)) {

        if let converter = converter {
            completion(Result.success(converter))
        } else {
            completion(Result.failure(ErrorResult.custom(string: "No converter")))
        }
    }
}

