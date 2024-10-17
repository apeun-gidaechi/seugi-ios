import Foundation
import Domain
import Swinject

public struct OAuthAssembly: Assembly {
    public init() {}
    public func assemble(container: Container) {
        container.register(OAuthRepo.self) {
            OAuthService(runner: $0.resolve(NetRunner.self)!)
        }.inObjectScope(.container)
    }
}
