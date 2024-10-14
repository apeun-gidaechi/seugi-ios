import Foundation
import Domain
import SwiftUtil
import Swinject

public final class KeyValueAssembly: Assembly {
    public init() {}
    public func assemble(container: Container) {
        container.register(KeyValueRepo.self) { _ in
            UserDefaultsStore(userDefaults: .seugi)
        }
        .inObjectScope(.container)
    }
}
