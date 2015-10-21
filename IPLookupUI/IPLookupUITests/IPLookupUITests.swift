//
//  IPLookupUITests.swift
//  IPLookupUITests
//
//  Created by Oliver Eikemeier on 27.09.15.
//  Copyright © 2015 Zalando SE. All rights reserved.
//

import XCTest

class IPLookupUITests: XCTestCase {
    
    let app = XCUIApplication()
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        
        app.launch()
    }
    
    override func tearDown() {
        app.terminate()
        super.tearDown()
    }
    
    func testIPv4() {
        runTest("IPv4", expectingResult: "69.89.31.226", timeout: 3.0)
    }
    
    func testIPv6() {
        runTest("IPv6", expectingResult: "2001:0db8:85a3:08d3:1319:8a2e:0370:7344", timeout: 3.0)
    }
    
    func testImmediate() {
        runTest("Immediate", expectingResult: "127.0.0.1", timeout: 0.1)
    }
    
    func testTimeout() {
        app.tables.cells.elementMatchingType(.Cell, identifier: "Timeout").tap()
        waitForLookup(9.0)
    }
    
    func testAlternate() {
        app.tables.cells.elementMatchingType(.Cell, identifier: "Alternating").tap()
        waitForLookup(3.0)
        waitForLookup(0.1)
        let myIPText = app.staticTexts.elementMatchingType(.StaticText, identifier: "IP Label")
        XCTAssert(myIPText.label.containsString("127.0.0.1"))
    }
    
    private func runTest(text: String, expectingResult result: String, timeout: NSTimeInterval) {
        app.tables.cells.elementMatchingType(.Cell, identifier: text).tap()
        waitForLookup(timeout)
        checkForResult(result)
    }

    private func waitForLookup(timeout: NSTimeInterval) {
        let lookupButton = app.buttons.elementMatchingType(.Button, identifier: "IP Lookup")
        let lookupEnabled = NSPredicate(format: "enabled == true")
        
        lookupButton.tap()
        expectationForPredicate(lookupEnabled, evaluatedWithObject: lookupButton, handler: nil)
        waitForExpectationsWithTimeout(timeout, handler: nil)
    }

    private func checkForResult(result: String) {
        let myIPText = app.staticTexts.elementMatchingType(.StaticText, identifier: "IP Label")
        XCTAssert(myIPText.label.containsString(result))
    }
}
