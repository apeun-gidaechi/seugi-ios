import Foundation

import Domain

import Swinject

public struct OAuthAssembly: Assembly {
    public init() {}
    public func assemble(container: Container) {
        container.register(OAuthRepo.self) { _ in
            OAuthService()
        }
    }
}
