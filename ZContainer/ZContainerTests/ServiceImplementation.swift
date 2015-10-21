//
//  ServiceImplementation.swift
//  ZContainerTests
//
//  Created by Oliver Eikemeier on 17.09.15.
//  Copyright © 2015 Zalando SE. All rights reserved.
//

import Foundation

class ServiceImplementation {
    private(set) var identity: String
    
    private static var serviceCounter: Int64 = 0
    
    init() {
        let value = OSAtomicIncrement64(&ServiceImplementation.serviceCounter)
        identity = "Service implementation \(value))"
    }
    
    private static let privateSharedInstance = ServiceImplementation()
    
    class func sharedInstance() -> ServiceImplementation {
        return privateSharedInstance
    }
}
