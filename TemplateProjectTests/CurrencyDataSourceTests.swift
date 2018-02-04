//
//  CurrencyDataSourceTests.swift
//  TemplateProjectTests
//
//  Created by Benoit PASQUIER on 01/02/2018.
//  Copyright © 2018 Benoit PASQUIER. All rights reserved.
//

import XCTest
@testable import TemplateProject

class CurrencyDataSourceTests: XCTestCase {
    
    var dataSource : CurrencyDataSource!
    
    override func setUp() {
        super.setUp()
        dataSource = CurrencyDataSource()
    }
    
    override func tearDown() {
        dataSource = nil
        super.tearDown()
    }
    
    func testEmptyValueInDataSource() {
        
        // giving empty data value
        dataSource.data.value = []
        
        let tableView = UITableView()
        tableView.dataSource = dataSource
        
        // expected one section
        XCTAssertEqual(dataSource.numberOfSections(in: tableView), 1, "Expected one section in table view")
        
        // expected zero cells
        XCTAssertEqual(dataSource.tableView(tableView, numberOfRowsInSection: 0), 0, "Expected no cell in table view")
    }
    
    func testValueInDataSource() {
        
        // giving data value
        let euroRate = CurrencyRate(currencyIso: "EUR", rate: 1.14)
        let dollarRate = CurrencyRate(currencyIso: "EUR", rate: 1.40)
        dataSource.data.value = [euroRate, dollarRate]
        
        let tableView = UITableView()
        tableView.dataSource = dataSource
        
        // expected one section
        XCTAssertEqual(dataSource.numberOfSections(in: tableView), 1, "Expected one section in table view")
        
        // expected two cells
        XCTAssertEqual(dataSource.tableView(tableView, numberOfRowsInSection: 0), 2, "Expected two cell in table view")
    }
    
    func testValueCell() {
        
        // giving data value
        let dollarRate = CurrencyRate(currencyIso: "EUR", rate: 1.40)
        dataSource.data.value = [dollarRate]
        
        let tableView = UITableView()
        tableView.dataSource = dataSource
        tableView.register(CurrencyCell.self, forCellReuseIdentifier: "CurrencyCell")
        
        let indexPath = IndexPath(row: 0, section: 0)
        
        // expected CurrencyCell class
        guard let _ = dataSource.tableView(tableView, cellForRowAt: indexPath) as? CurrencyCell else {
            XCTAssert(false, "Expected CurrencyCell class")
            return
        }        
    }
}
