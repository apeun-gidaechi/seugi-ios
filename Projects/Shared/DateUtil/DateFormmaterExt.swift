import Foundation

public extension DateFormatter {
    convenience init(type: DateFormatterType) {
        self.init()
        self.dateFormat = type.rawValue
        self.timeZone = .init(abbreviation: "UTC")
    }
}
