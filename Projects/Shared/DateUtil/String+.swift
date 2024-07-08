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
        let date = DateFormatter.localDateTime.date(from: str)
        // 9시간 (9 * 60 * 60 초) 더하기
        return date?.addingTimeInterval(9 * 60 * 60)
    }
    
    var localDate: Date? {
        // 9시간 (9 * 60 * 60 초) 더하기
        let date = DateFormatter.localDate.date(from: self)
        return date?.addingTimeInterval(9 * 60 * 60)
    }
}

private func makeDateFormatter(_ dateFormat: String) -> DateFormatter {
    let formatter = DateFormatter()
    formatter.dateFormat = dateFormat
    formatter.timeZone = TimeZone(identifier: "Asia/Seoul")
    return formatter
}
