//
//  ContainerTests.swift
//  ZContainerTests
//
//  Created by Oliver Eikemeier on 17.09.15.
//  Copyright © 2015 Zalando SE. All rights reserved.
//

import XCTest
@testable import ZContainer

protocol Service {
    var identity: String { get }
}

extension ServiceImplementation: Service { }

class ContainerTests: XCTestCase {
    var container: ZContainer!
    
    override func setUp() {
        super.setUp()
        
        let registry = ZContainer.createRegistry(check: false)
        registry.register { ServiceImplementation() as Service }
        
        container = registry.container()
    }
    
    func testRetrieval() {
        let _: Service = container.resolve()
    }
    
    func testOptionalRetrieval() {
        let service: Service?
        service = container.resolve()
        XCTAssertNotNil(service)
    }
    
    func testImplicitlyUnwrappedRetrieval() {
        let service: Service!
        service = container.resolve()
        XCTAssertNotNil(service)
    }
    
    func testLookupPerformance() {
        measureBlock {
            for _ in 1...10_000 {
                let _: Service = self.container.resolve()
            }
        }
    }
}
