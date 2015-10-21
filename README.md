# Modular iOS Application Architecture Demo Project

### Sample Code from a Talk Held at the Cocoaheads Berlin October 2015 Meeting

## Design Decisions:

A [Service Locator](http://www.martinfowler.com/articles/injection.html#UsingAServiceLocator) is used to decouple modules from their dependencies.

- The Service Locator is a global dependency, but has only one interface. This makes the coupling not too bad and easily replaceable.

- Resolving service dependencies should only be done in _init()_, causing it to work more like a dependency injection framework.

- Configuration is only done once at application start, making it immutable afterwards and removing the need for locks.

- Services are guaranteed to be available. Misconfiguration of the service locator is a programmer error, resulting in the application to “[Crash Early](https://pragprog.com/book/tpp/the-pragmatic-programmer)”.

- Dependencies should form a tree (without loops), mirroring “[Clean Architecture](https://blog.8thlight.com/uncle-bob/2012/08/13/the-clean-architecture.html)”. 

Regarding structuring dependencies, see “Design information flow” in [WWDC 2014 Session 229: Advanced iOS Application Architecture and Patterns](https://developer.apple.com/videos/play/wwdc2014-229/).

Regarding asynchronous modularization techniques, see “Subdivide app into independent subsystems” in [WWDC 2012 Session 712: Asynchronous Design Patterns with Blocks, GCD, and XPC](https://developer.apple.com/videos/play/wwdc2012-712/).

Note that for passing data across asynchronous boundaries (which interfaces can represent) it might be advisable to use some [Future](https://twitter.github.io/scala_school/finagle.html#Future)– or [Rx](http://reactivex.io)–style library. Otherwise I would discourage most other global dependencies, since it tends to become a PITA fast.
