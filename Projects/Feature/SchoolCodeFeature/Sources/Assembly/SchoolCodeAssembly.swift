import SchoolCodeFeatureInterface
import Swinject

public final class SchoolCodeAssembly: Assembly {
    public init() {}
    public func assemble(container: Container) {
        container.register((any SchoolCodeFactory).self) { _ in
            SchoolCodeFactoryImpl()
        }.inObjectScope(.container)
    }
}
