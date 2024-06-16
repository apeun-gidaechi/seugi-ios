import Swinject
import Domain

public final class MemberAssembly: Assembly {
    public init() {}
    public func assemble(container: Container) {
        container.register(MemberRepo.self) { _ in
            MemberService()
        }
    }
}
