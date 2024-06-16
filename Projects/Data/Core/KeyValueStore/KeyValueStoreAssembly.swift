import Foundation
import Domain
import Swinject

public final class KeyValueStoreAssembly: Assembly {
    public init() {}
    public func assemble(container: Container) {
        container.register(KeyValueRepo.self) { _ in
            UserDefaultsKeyValueStore(userDefaults: .seugi)
        }
        .inObjectScope(.container)
    }
}
