//
//  RegisterServices.swift
//  ModularDemo
//
//  Created by Oliver Eikemeier on 26.09.15.
//  Copyright © 2015 Zalando SE. All rights reserved.
//

import ZContainer
import IPLookupUI
import IPLookupService

private let serviceURL = "https://api.ipify.org/"
private let timeout = 5.0

extension IPLookupService: IPLookupUIService { }

func registerServices() {
    let registry = ZContainer.defaultRegistry()
    
    let lookupService = IPLookupService(url: serviceURL, timeout: timeout)
    registry.register { lookupService as IPLookupUIService }
}
