//
//  ZContainer.swift
//  ZContainer
//
//  Created by Oliver Eikemeier on 17.09.15.
//  Copyright © 2015 Zalando SE. All rights reserved.
//

import Foundation

/// Service Registry
public protocol ZRegistry {
    func register<Service>(factory: () -> Service)
    
    func container() -> ZContainer
}

/// Service Locator
public class ZContainer {
    // MARK: - Shared Instance
    private static let sharedRegistry = ServiceRegistry()
    
    /// Returns the default service locator.
    public static func defaultContainer() -> ZContainer {
        return sharedRegistry
    }
    
    /// Returns the default service registy.
    public static func defaultRegistry() -> ZRegistry {
        return sharedRegistry
    }
    
    /// Create a new service registy.
    public static func createRegistry(check check: Bool = true) -> ZRegistry {
        return ServiceRegistry(check: check)
    }
    
    // MARK: - Private Properties
    private var registry = [ObjectIdentifier: Any]()
    private let check: Bool
    
    private init(check: Bool = true) {
        self.check = check
    }
    
    /// Returns a service matching the requested type.
    public func resolve<Service>(file: StaticString = __FILE__, line: UInt = __LINE__, function: StaticString = __FUNCTION__) -> Service! {
        if check {
            assert(function.stringValue.hasPrefix("init"), "resolve() should be called in init", file: file, line: line)
        }
        let serviceIdentifier = ObjectIdentifier(Service.self)
        guard let factory = registry[serviceIdentifier] as? () -> Service else {
            if check {
                fatalError("No registered factory for \(Service.self)", file: file, line: line)
            }
            return Service!()
        }
        return factory()
    }
}

private class ServiceRegistry: ZContainer, ZRegistry {
    func register<Service>(factory: () -> Service) {
        let serviceIdentifier = ObjectIdentifier(Service.self)
        registry[serviceIdentifier] = factory
    }

    func container() -> ZContainer {
        return self
    }
}
