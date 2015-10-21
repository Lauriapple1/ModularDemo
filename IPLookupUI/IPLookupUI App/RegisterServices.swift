//
//  RegisterServices.swift
//  IPLookupUI App
//
//  Created by Oliver Eikemeier on 26.09.15.
//  Copyright © 2015 Zalando SE. All rights reserved.
//

import Foundation
import ZContainer
import IPLookupUI

func registerServices() {
    let registry = ZContainer.defaultRegistry()
    
    registry.register { MyIPTestService.sharedService() as IPLookupUIService }
}
