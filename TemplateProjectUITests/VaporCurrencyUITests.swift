//
//  VapoCurrencyUITests.swift
//  TemplateProjectUITests
//
//  Created by Benoit PASQUIER on 28/04/2019.
//  Copyright © 2019 Benoit PASQUIER. All rights reserved.
//

import XCTest

class VaporCurrencyUITests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    

    func testExample() {
        let app = XCUIApplication()
        app.launchEnvironment = ["BASEURL" : "http://localhost:8080"]
        app.launch()
        let tablesQuery = app.tables
        let count = tablesQuery.cells.count
        XCTAssert(count == 4)
    }

}
