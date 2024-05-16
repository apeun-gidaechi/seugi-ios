import Foundation

public extension UserDefaults {
    static let seugi = UserDefaults(suiteName: "com.seugi") ?? .standard
}
