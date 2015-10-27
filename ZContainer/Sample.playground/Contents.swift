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

//: Register the service

let registry = ZContainer.defaultRegistry()

extension DuplicationService: StringProcessor { }

registry.register { DuplicationService() as StringProcessor }

//: Use the client

let client = Client()

print(client.process("Hello, world"))
