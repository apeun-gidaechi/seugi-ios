import Foundation
import Domain

final class UserDefaultsKeyValueStore: KeyValueRepo {
    private let userDefaults: UserDefaults

    init(userDefaults: UserDefaults) {
        self.userDefaults = userDefaults
    }

    func save(key: StorableKeys, value: Any) {
        userDefaults.setValue(value, forKey: key.rawValue)
    }

    func load(key: StorableKeys) -> Any? {
        userDefaults.value(forKey: key.rawValue)
    }

    func load<T>(key: StorableKeys) -> T? {
        userDefaults.value(forKey: key.rawValue) as? T
    }

    func delete(key: StorableKeys) {
        userDefaults.removeObject(forKey: key.rawValue)
    }

    func save(key: String, value: Any) {
        userDefaults.setValue(value, forKey: key)
    }

    func load(key: String) -> Any? {
        userDefaults.value(forKey: key)
    }

    func load<T>(key: String) -> T? {
        userDefaults.value(forKey: key) as? T
    }

    func delete(key: String) {
        userDefaults.removeObject(forKey: key)
    }
}
