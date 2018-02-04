//
//  CurrencyServiceTests.swift
//  TemplateProjectTests
//
//  Created by Benoit PASQUIER on 01/02/2018.
//  Copyright © 2018 Benoit PASQUIER. All rights reserved.
//

import XCTest
@testable import TemplateProject

class CurrencyServiceTests: XCTestCase {
    
    func testCancelRequest() {
        
        // giving a "previous" session
        CurrencyService.shared.fetchConverter { (_) in
            // ignore call
        }
        
        // Expected to task nil after cancel
        CurrencyService.shared.cancelFetchCurrencies()
        XCTAssertNil(CurrencyService.shared.task, "Expected task nil")
    }
}
