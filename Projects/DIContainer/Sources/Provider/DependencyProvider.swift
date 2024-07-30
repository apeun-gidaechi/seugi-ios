import Swinject

public final class DependencyProvider {
    
    public static let shared = DependencyProvider()
    
    public let container = Container()
}
