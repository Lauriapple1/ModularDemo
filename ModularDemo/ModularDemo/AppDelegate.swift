//
//  AppDelegate.swift
//  ModularDemo
//
//  Created by Oliver Eikemeier on 26.09.15.
//  Copyright © 2015 Zalando SE. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    override init() {
        super.init()
        
        let userDefaults = NSUserDefaults.standardUserDefaults()
        registerUserDefaults(userDefaults)
        
        if loggingPreference(userDefaults) {
            registerLoggingServices()
        }
        else {
            registerServices()
        }
    }
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        return true
    }
}
