import Foundation
import UserDefaultInterface
import Swinject

public final class KeyValueStoreAssembly: Assembly {
    public init() {}
    public func assemble(container: Container) {
        container.register(KeyValueStore.self) { _ in
            UserDefaultsKeyValueStore(userDefaults: .seugi)
        }
        .inObjectScope(.container)
    }
}
