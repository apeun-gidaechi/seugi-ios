import Swinject
import Domain

public final class FileAssembly: Assembly {
    public init() {}
    public func assemble(container: Container) {
        container.register((any FileRepo).self) { _ in
            FileService()
        }
    }
}
