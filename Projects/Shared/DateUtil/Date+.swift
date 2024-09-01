import Foundation

public extension Date {
    var timeAgo: String {
        let currentDate = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: self, to: currentDate)
        
        return if let years = components.year, years > 0 {
            "\(years)년 전"
        } else if let months = components.month, months > 0 {
            "\(months)개월 전"
        } else if let days = components.day, days > 0 {
            "\(days)일 전"
        } else if let hours = components.hour, hours > 0 {
            "\(hours)시간 전"
        } else if let minutes = components.minute, minutes > 0 {
            "\(minutes)분 전"
        } else {
            "방금 전"
        }
    }
    
    var adjustedString: String {
        let dateFormatter = DateFormatter()
        let calendar = Calendar.current
        let now = Date()
        
        // 어제 날짜 계산
        let startOfToday = calendar.startOfDay(for: now)
        let startOfYesterday = calendar.date(byAdding: .day, value: -1, to: startOfToday)!
        
        // 작년 날짜 계산
        let startOfThisYear = calendar.date(from: calendar.dateComponents([.year], from: now))!
        let startOfLastYear = calendar.date(byAdding: .year, value: -1, to: startOfThisYear)!
        
        if self >= startOfToday {
            // 오늘 날짜
            dateFormatter.locale = Locale(identifier: "ko_KR")
            dateFormatter.dateFormat = "a hh:mm"
        } else if self >= startOfYesterday {
            // 어제 날짜
            dateFormatter.locale = Locale(identifier: "ko_KR")
            dateFormatter.dateFormat = "M월 d일"
        } else if self >= startOfLastYear {
            // 올해 날짜
            dateFormatter.locale = Locale(identifier: "ko_KR")
            dateFormatter.dateFormat = "M월 d일"
        } else {
            // 작년 및 그 이전 날짜
            dateFormatter.locale = Locale(identifier: "ko_KR")
            dateFormatter.dateFormat = "y년 M월 d일"
        }
        
        let dateString = dateFormatter.string(from: self)
        return dateString
    }
    
    func parseString(_ str: String) -> String {
        let dateFormatter = DateFormatter(str)
        let formattedDate = dateFormatter.string(from: self)
        return formattedDate
    }
}
