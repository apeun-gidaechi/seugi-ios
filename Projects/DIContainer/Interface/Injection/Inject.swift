import Swinject

@propertyWrapper
public struct Inject<T> {
    
    public let wrappedValue: T = {
        if let value = DependencyProvider.shared.container.resolve(T.self) {
            return value
        } else {
            fatalError("Injection error: \(T.self)")
        }
    }()
    
    public init() {}
}

struct Meditor {
    
    let dependencyProvider: DependencyProvider
    
    init(
        dependencyProvider: DependencyProvider
    ) {
        self.dependencyProvider = dependencyProvider
    }
    
}
