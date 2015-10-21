//
//  IPLookupServiceTests.swift
//  IPLookupServiceTests
//
//  Created by Oliver Eikemeier on 26.09.15.
//  Copyright © 2015 Zalando SE. All rights reserved.
//

import XCTest
import ZContainer
@testable import IPLookupService

enum SomeRandomError: ErrorType {
    case Unknown
}

class IPLookupServiceTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testFetch() {
        let demoService = IPLookupService(url: "https://api.ipify.org/", timeout: 5.0)
        
        let expectation = expectationWithDescription("HTTP call finished")

        demoService.lookupIP { (string, error) in
            XCTAssertNotNil(string)
            XCTAssertNil(error)
            expectation.fulfill()
        }

        waitForExpectationsWithTimeout(5.0, handler: nil)
    }
    
    func testTimeout() {
        let demoService = IPLookupService(url: "https://api.ipify.org/", timeout: 0.001)
        
        let expectation = expectationWithDescription("HTTP call finished")
        
        demoService.lookupIP { (string, error) in
            XCTAssertNil(string)
            XCTAssertEqual((error as? NSError)?.domain, NSURLErrorDomain)
            XCTAssertEqual((error as? NSError)?.code, NSURLErrorTimedOut)
            expectation.fulfill()
        }

        waitForExpectationsWithTimeout(5.0, handler: nil)
    }
    
    func testURL() {
        let demoService = IPLookupService(url: "", timeout: 5.0)
        
        let expectation = expectationWithDescription("HTTP call finished")
        
        demoService.lookupIP { (string, error) in
            XCTAssertNil(string)
            XCTAssertNotNil(error)
            expectation.fulfill()
        }

        waitForExpectationsWithTimeout(5.0, handler: nil)
    }
}
