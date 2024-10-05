import Foundation

import Domain

import Swinject

public final class KeychainAssembly: Assembly {
    public init() {}
    public func assemble(container: Container) {
        container.register(KeychainRepo.self) { _ in
            KeychainStore()
        }
    }
}
