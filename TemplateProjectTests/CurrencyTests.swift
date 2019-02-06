//
//  CurrencyTests.swift
//  TemplateProjectTests
//
//  Created by Benoit PASQUIER on 01/02/2018.
//  Copyright © 2018 Benoit PASQUIER. All rights reserved.
//

import XCTest
@testable import TemplateProject

class CurrencyTests: XCTestCase {
    
    func testParseEmptyCurrency() {
        
        // giving empty data
        let data = Data()
        
        // giving completion after parsing 
        // expected valid converter with valid data
        let completion : ((Result<Converter, ErrorResult>) -> Void) = { result in
            switch result {
            case .success(_):    
                XCTAssert(false, "Expected failure when no data")
            default:
                break
            }
        }
        
        ParserHelper.parse(data: data, completion: completion)
    }
    
    func testParseCurrency() {
        
        // giving a sample json file
        guard let data = FileManager.readJson(forResource: "sample") else {
            XCTAssert(false, "Can't get data from sample.json")
            return
        }
        
        // giving completion after parsing 
        // expected valid converter with valid data
        let completion : ((Result<Converter, ErrorResult>) -> Void) = { result in
            switch result {
            case .failure(_):
                XCTAssert(false, "Expected valid converter")
            case .success(let converter):
                
                XCTAssertEqual(converter.base, "GBP", "Expected GBP base")
                XCTAssertEqual(converter.date, "2018-02-01", "Expected 2018-02-01 date")
                XCTAssertEqual(converter.rates.count, 32, "Expected 32 rates")
            }
        }
        
        ParserHelper.parse(data: data, completion: completion)
    }
    
    func testWrongKeyCurrency() {
        
        // giving a wrong dictionary
        let dictionary = ["test" : 123 as AnyObject]
        
        // expected to return error of converter
        let result = Converter.parseObject(dictionary: dictionary)
        
        switch result {
        case .success(_):
            XCTAssert(false, "Expected failure when wrong data")
        default:
            return
        }
    }
}
