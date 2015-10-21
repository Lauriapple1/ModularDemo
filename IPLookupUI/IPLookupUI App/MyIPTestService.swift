//
//  MyIPTestService.swift
//  IPLookupUI App
//
//  Created by Oliver Eikemeier on 26.09.15.
//  Copyright © 2015 Zalando SE. All rights reserved.
//

import Foundation
import ZContainer
import IPLookupUI

class MyIPTestService: IPLookupUIService {
    // MARK: - Shared Instance
    private static let sharedInstance = MyIPTestService()
    
    static func sharedService() -> MyIPTestService {
        return MyIPTestService.sharedInstance
    }
    
    // MARK: - Result Type
    enum ResultType {
        case IPv4, IPv6, Timeout, Immediate, Alternating
    }
    
    var resultType: ResultType
    
    private init(resultType: ResultType = .Immediate) {
        self.resultType = resultType
    }
    
    // MARK: - Lookup Simulation
    private let completionQueue = dispatch_get_global_queue(QOS_CLASS_DEFAULT, 0)
    
    private func complete(after delta: NSTimeInterval = 0.0, IP: String? = nil, error: ErrorType? = nil, completionHandler: (IP: String?, error: ErrorType?) -> Void) {
        let when: dispatch_time_t
        if delta > 0 {
            let offset = Int64(delta * Double(NSEC_PER_SEC))
            when = dispatch_time(DISPATCH_TIME_NOW, offset)
        }
        else {
            when = DISPATCH_TIME_NOW
        }
        
        dispatch_after(when, completionQueue) {
            completionHandler(IP: IP, error: error)
        }
    }
    
    private var timeoutResult = true
    
    func lookupIP(completionHandler: (IP: String?, error: ErrorType?) -> Void) {
        switch resultType {
        case .IPv4:
            complete(after: 2.0, IP: "69.89.31.226", completionHandler: completionHandler)
            
        case .IPv6:
            complete(after: 2.0, IP: "2001:0db8:85a3:08d3:1319:8a2e:0370:7344", completionHandler: completionHandler)
            
        case .Timeout:
            complete(after: 5.0, error: NSURLError.TimedOut, completionHandler: completionHandler)
            
        case .Immediate:
            complete(IP: "127.0.0.1", completionHandler: completionHandler)
            
        case .Alternating:
            if timeoutResult {
                complete(after: 2.0, error: NSURLError.TimedOut, completionHandler: completionHandler)
            }
            else {
                complete(IP: "127.0.0.1", completionHandler: completionHandler)
            }
            timeoutResult = !timeoutResult
        }
    }
}
