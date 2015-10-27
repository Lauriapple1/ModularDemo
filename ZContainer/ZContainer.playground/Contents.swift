//: ZContainer - A Service Locator

var registry = [ObjectIdentifier : Any]()

func register<Service>(factory: () -> Service) {
    let serviceIdentifier = ObjectIdentifier(Service.self)
    registry[serviceIdentifier] = factory
}

func resolve<Service>() -> Service! {
    let serviceIdentifier = ObjectIdentifier(Service.self)
    guard let factory = registry[serviceIdentifier] as? () -> Service else {
        return Service!()
    }
    return factory()
}

//: Sample Service

public protocol StringProcessor {
    func process(string: String) -> String
}

class Duplicator: StringProcessor {
    func process(string: String) -> String {
        return String(string.characters.flatMap { [$0, $0] })
    }
}

register { Duplicator() as StringProcessor }

//: Sample Client

let processor: StringProcessor = resolve()

processor.process("Hello, world")
