//: ZContainer - A Service Locator

import ZContainer

//: Just the client, declaring **all** dependencies

// DIP: objectmentor.com/resources/articles/dip.pdf
// “High level modules should not depend upon low level modules”
public protocol StringProcessor {
    func process(string: String) -> String
}

class Client {
    // “Just Declare Static Dependencies, Leave Object Graph Composition to the Framework”
    private let processor: StringProcessor

    // Service Locator: martinfowler.com/articles/injection.html
    init() {
        let container = ZContainer.defaultContainer()
        processor = container.resolve()
    }
    
    func process(string: String) -> String{
        let processed = processor.process(string)
        
        return "\(string) -> \(processed)"
    }
}

//: A service, **independent** of the client

class DuplicationService {
    func process(string: String) -> String {
        return String(string.characters.flatMap { [$0, $0] })
    }
}

//: An alternative service, independent too

class UppercaseService {
    func process(string: String) -> String {
        return string.uppercaseString
    }
}

//: Another client, declaring its dependencies

public protocol StringTransformer {
    func transform(string: String) -> String
}

class SecondClient {
    private let transformer: StringTransformer
    
    init() {
        let container = ZContainer.defaultContainer()
        transformer = container.resolve()
    }
    
    func process(string: String) -> String{
        let processed = transformer.transform(string)
        
        return "Transforming \"\(string)\" to \"\(processed)\""
    }
}

//: Register the service

let registry = ZContainer.defaultRegistry()

extension DuplicationService: StringProcessor { }

extension UppercaseService: StringProcessor { }

extension DuplicationService: StringTransformer {
    func transform(string: String) -> String {
        return process(string)
    }
}

extension UppercaseService: StringTransformer {
    func transform(string: String) -> String {
        return process(string)
    }
}

registry.register { DuplicationService() as StringProcessor }
registry.register { UppercaseService() as StringTransformer }

//: Use the client

let client = Client()
let secondClient = SecondClient()

print(client.process("Hello, world"))
print(secondClient.process("Good bye"))

