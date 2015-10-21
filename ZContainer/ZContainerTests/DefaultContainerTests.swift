//
//  DefaultContainerTests.swift
//  ZContainerTests
//
//  Created by Oliver Eikemeier on 25.09.15.
//  Copyright © 2015 Zalando SE. All rights reserved.
//

import XCTest
@testable import ZContainer

class DefaultContainerTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        
        let registry = ZContainer.defaultRegistry()
        registry.register { ServiceImplementation() as Service }
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    struct ContainerTest {
        private let service: Service
        init() {
            let container = ZContainer.defaultContainer()
            service = container.resolve()
        }
    }
    
    func testDefaultZContainer() {
        let _ = ContainerTest()
    }
}
