//
//  LoggingDecorator.swift
//  LoggingDecorator
//
//  Created by Oliver Eikemeier on 28.09.15.
//  Copyright © 2015 Zalando SE. All rights reserved.
//

import Foundation

public protocol DecoratedService {
    func lookupIP(completionHandler: (IP: String?, error: ErrorType?) -> Void) -> Void
}

public class LoggingDecorator {
    private let service: DecoratedService
    
    public init(service: DecoratedService) {
        self.service = service
    }
    
    private var callCount: Int32 = 0
    
    public func lookupIP(completionHandler: (IP: String?, error: ErrorType?) -> Void) {
        let callNumber = OSAtomicIncrement32(&callCount)
        let now = NSDate()
        
        service.lookupIP { (IP, error) in
            let elapsed = -now.timeIntervalSinceNow
            let logEntry = String(format: "Call %d Completed in %0.2f ms, result: %@", callNumber, elapsed * 1_000, IP ?? "Failed")
            print(logEntry)
            
            let modifiedIP = IP.map { "|>\($0)<|" }
            completionHandler(IP: modifiedIP, error: error)
        }
    }
}
