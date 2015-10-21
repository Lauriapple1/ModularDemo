//
//  IPLookupUIService.swift
//  IPLookupUI
//
//  Created by Oliver Eikemeier on 26.09.15.
//  Copyright © 2015 Zalando SE. All rights reserved.
//

import Foundation

public protocol IPLookupUIService {
    func lookupIP(completionHandler: (IP: String?, error: ErrorType?) -> Void) -> Void
}
