import Foundation

public extension DateFormatter {
    convenience init(type: DateFormatterType, locale: Locale = Locale(identifier: "ko_KR")) {
        self.init()
        self.dateFormat = type.rawValue
        self.locale = locale
    }
}
