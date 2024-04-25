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
    
    var monthPerDay: String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd"
        return dateFormatter.string(from: self)
    }
    
    static var datesForWeek: [Date] {
        var datesInWeek: [Date] = []
        let currentDate = Date()
        let calendar = Calendar.current
        var startDate = calendar.startOfDay(for: currentDate)
        for _ in 1...7 {
            datesInWeek.append(startDate)
            startDate = calendar.date(byAdding: .day, value: -1, to: startDate) ?? .now
        }
        return datesInWeek.reversed()
    }
}
