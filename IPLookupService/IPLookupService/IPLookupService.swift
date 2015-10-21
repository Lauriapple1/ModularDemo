//
//  IPLookupService.swift
//  IPLookupService
//
//  Created by Oliver Eikemeier on 26.09.15.
//  Copyright © 2015 Zalando SE. All rights reserved.
//

import Foundation
import ZContainer

public enum IPLookupServiceError: ErrorType {
    case InternalError
    case DecodingError
}

public class IPLookupService {
    private let serviceURL: NSURL?
    private let session: NSURLSession
    
    public init(url: String, timeout: NSTimeInterval) {
        serviceURL = NSURLComponents(string: url)?.URL
        
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        configuration.timeoutIntervalForResource = timeout
        session = NSURLSession(configuration: configuration)
    }
    
    public func lookupIP(completionHandler: (IP: String?, error: ErrorType?) -> Void) {
        guard let URL = serviceURL else {
            let queue = dispatch_get_global_queue(QOS_CLASS_DEFAULT, 0)
            dispatch_async(queue) {
                completionHandler(IP: nil, error: IPLookupServiceError.InternalError)
            }
            return
        }
        
        let task = session.dataTaskWithURL(URL) { (data, response, error) in
            switch (data, error) {
            case let (data?, nil):
                guard let result = String(data: data, encoding: NSASCIIStringEncoding) else {
                    completionHandler(IP: nil, error: IPLookupServiceError.DecodingError)
                    break
                }
                
                completionHandler(IP: result, error: nil)
                
            case let (nil, error?):
                completionHandler(IP: nil, error: error)
                
            default:
                completionHandler(IP: nil, error: IPLookupServiceError.InternalError)
            }
        }
        
        task.resume()
    }
}
