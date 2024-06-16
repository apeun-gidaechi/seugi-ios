import Foundation

public extension DateFormatter {
    static var localDateTime: DateFormatter {
        makeDateFormatter("yyyy-MM-dd HH:mm:ss.SSSSSS")
    }
    
    static var localDate: DateFormatter {
        makeDateFormatter("yyyy-MM-dd")
    }
}

public extension String {
    var localDateTime: Date? {
        var str = self
        str.replace("T", with: " ")
        return DateFormatter.localDateTime.date(from: str)
    }
    
    var localDate: Date? {
        return DateFormatter.localDate.date(from: self)
    }
}

private func makeDateFormatter(_ dateFormat: String) -> DateFormatter {
    let formatter = DateFormatter()
    formatter.dateFormat = dateFormat
    formatter.timeZone = TimeZone(identifier: "Asia/Seoul")
    return formatter
}
