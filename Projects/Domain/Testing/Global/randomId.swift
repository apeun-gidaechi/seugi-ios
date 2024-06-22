import Foundation

extension Int {
    static func randomId() -> Int {
        Int.random(in: 0..<100000)
    }
    
    static func randomIn10() -> Int {
        Int.random(in: 0..<10)
    }
    
    static func randomIn100() -> Int {
        Int.random(in: 0..<100)
    }
    
    static func randomIn1000() -> Int {
        Int.random(in: 0..<1000)
    }
}

extension String {
    static func randomUUID() -> String {
        UUID().uuidString
    }
}
