import Domain
import Swinject

public final class FileAssembly: Assembly {
    public init() {}
    public func assemble(container: Container) {
        container.register(FileRepo.self) {
            FileService(runner: $0.resolve(NetRunner.self)!)
        }.inObjectScope(.container)
    }
}
