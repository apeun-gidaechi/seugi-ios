import Foundation

public extension String {
    var localDateTime: Date? {
        var str = self
        str.replace("T", with: " ")
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSSSSS"
        dateFormatter.timeZone = TimeZone(identifier: "Asia/Seoul")
        return dateFormatter.date(from: str)
    }
    
    var localDate: Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = TimeZone(identifier: "Asia/Seoul")
        return dateFormatter.date(from: self)
    }
}
