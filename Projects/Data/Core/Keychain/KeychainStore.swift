import Foundation

import Domain

struct KeychainStore: KeychainRepo {
    private func create(_ value: String, for key: KeychainKeys) throws {
        let encodedData = value.data(using: String.Encoding.utf8)!
        let query: [CFString: Any] = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key.rawValue,
            kSecValueData: encodedData,
            kSecAttrAccessGroup: "com.seugi.keychain"
        ]
        let status = SecItemAdd(query as CFDictionary, nil)
        if status == errSecDuplicateItem {
            throw KeychainError.keyDuplicated
        }
    }
    
    private func update(_ value: String, for key: KeychainKeys) {
        let encodedData = value.data(using: String.Encoding.utf8)!
        let previousQuery: [CFString: Any] = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key.rawValue,
            kSecAttrAccessGroup: "com.seugi.keychain"
        ]
        let updateQuery: [CFString: Any] = [
            kSecValueData: encodedData,
            kSecAttrAccessGroup: "com.seugi.keychain"
        ]
        _ = SecItemUpdate(
            previousQuery as CFDictionary,
            updateQuery as CFDictionary
        )
    }
    
    func save(key: KeychainKeys, value: String) {
        do {
            try create(value, for: key)
        } catch {
            update(value, for: key)
        }
    }
    
    func load(key: KeychainKeys) -> String? {
        let query: [CFString: Any] = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key.rawValue,
            kSecReturnAttributes: true,
            kSecReturnData: true,
            kSecAttrAccessGroup: "com.seugi.keychain"
        ]
        var item: CFTypeRef?
        guard SecItemCopyMatching(query as CFDictionary, &item) == errSecSuccess,
              let unwrappedItem = item,
              let data = unwrappedItem[kSecValueData] as? Data,
              let decodedData = String(data: data, encoding: .utf8) else {
            return nil
        }
        return decodedData
    }
    
    func delete(key: KeychainKeys) {
        let deleteQuery: [CFString: Any] = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key.rawValue,
            kSecAttrAccessGroup: "com.seugi.keychain"
        ]
        _ = SecItemDelete(deleteQuery as CFDictionary)
    }
}
