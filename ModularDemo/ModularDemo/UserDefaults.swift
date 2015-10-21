//
//  UserDefaults.swift
//  ModularDemo
//
//  Created by Oliver Eikemeier on 20.10.15.
//  Copyright © 2015 Zalando SE. All rights reserved.
//

import Foundation

private let loggingPreferenceKey = "logging_preference"

func registerUserDefaults(userDefaults: NSUserDefaults) {
    let defaults = [loggingPreferenceKey: false]
    userDefaults.registerDefaults(defaults)
}

func loggingPreference(userDefaults: NSUserDefaults) -> Bool {
    return userDefaults.boolForKey(loggingPreferenceKey)
}
