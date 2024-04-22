import Foundation

struct ServiceConfiguration {
    static var googleClientId: String {
        guard let baseUrl = Bundle.main.object(forInfoDictionaryKey: "GoogleClientId") as? String else {
            fatalError("❌ GoogleClientId could not find in plist")
        }
        return baseUrl
    }
}
