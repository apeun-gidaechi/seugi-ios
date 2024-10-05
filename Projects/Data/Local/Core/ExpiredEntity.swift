import Foundation

public protocol ExpiredEntity {
    var expiredAt: Date { get }
    static var dayLater: Int { get }
}

public extension ExpiredEntity {
    var isExpired: Bool {
        return Date() > expiredAt
    }
    
    static var expiredDate: Date {
        Calendar.current.date(byAdding: .day, value: Self.dayLater, to: Date())!
    }
}
