//
//  RegisterLoggingServices.swift
//  ModularDemo
//
//  Created by Oliver Eikemeier on 26.09.15.
//  Copyright © 2015 Zalando SE. All rights reserved.
//

import ZContainer
import IPLookupUI
import IPLookupService
import LoggingDecorator

private let serviceURL = "https://api.ipify.org/"
private let timeout = 5.0

extension LoggingDecorator: IPLookupUIService { }
extension IPLookupService: DecoratedService { }

func registerLoggingServices() {
    let registry = ZContainer.defaultRegistry()
    
    let lookupService = IPLookupService(url: serviceURL, timeout: timeout)
    let logger = LoggingDecorator(service: lookupService)
    registry.register { logger as IPLookupUIService }
}
