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
