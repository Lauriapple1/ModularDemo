//
//  EmptyContainerTests.swift
//  ZContainerTests
//
//  Created by Oliver Eikemeier on 25.09.15.
//  Copyright © 2015 Zalando SE. All rights reserved.
//

import XCTest
@testable import ZContainer

class EmptyContainerTests: XCTestCase {
    var registry: ZRegistry!
    var container: ZContainer!
    
    override func setUp() {
        super.setUp()
        
        let containerRegistry = ServiceRegistry(check: false)
        registry = containerRegistry
        container = containerRegistry
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testNonexistent() {
        let service: Service!
        service = container.resolve()
        XCTAssertNil(service)
    }
    
    func testFactory() {
        registry.register { ServiceImplementation() as Service }
        
        let service1: Service
        let service2: Service
        service1 = container.resolve()
        service2 = container.resolve()
        XCTAssertNotEqual(service1.identity, service2.identity)
    }
    
    func testSingletonFactory() {
        registry.register { ServiceImplementation.sharedInstance() as Service }
        
        let service1: Service
        let service2: Service
        service1 = container.resolve()
        service2 = container.resolve()
        XCTAssertEqual(service1.identity, service2.identity)
    }
    
    func testLookupPerformance() {
        registry.register { ServiceImplementation.sharedInstance() as Service }
        measureBlock {
            for _ in 1...10_000 {
                let _: Service = self.container.resolve()
            }
        }
    }
}
