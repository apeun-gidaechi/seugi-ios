import Foundation

import Domain

import Swinject

public struct CatSeugiAssembly: Assembly {
    public init() {}
    public func assemble(container: Container) {
        container.register(CatSeugiRepo.self) { _ in
            CatSeugiService()
        }
    }
}
