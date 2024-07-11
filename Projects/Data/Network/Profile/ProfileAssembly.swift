import Swinject
import Domain

public final class ProfileAssembly: Assembly {
    public init() {}
    public func assemble(container: Container) {
        container.register(ProfileRepo.self) { _ in
            ProfileService()
        }
    }
}
