import Domain

import Swinject

public final class ProfileAssembly: Assembly {
    public init() {}
    public func assemble(container: Container) {
        container.register(ProfileRepo.self) {
            ProfileService(runner: $0.resolve(NetRunner.self)!)
        }.inObjectScope(.container)
    }
}
