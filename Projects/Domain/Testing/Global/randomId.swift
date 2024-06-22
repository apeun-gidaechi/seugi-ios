import Foundation

extension Int {
    static func randomId() -> Int {
        Int.random(in: 0..<100000)
    }
}

extension String {
    static func randomUUID() -> String {
        UUID().uuidString
    }
}
