import Foundation

public extension Date {
    var timeAgoText: String {
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
    
    var prettyText: String {
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
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = str
        let formattedDate = dateFormatter.string(from: self)
        return formattedDate
    }
    
    func parseString(type: DateFormatterType) -> String {
        let dateFormatter = DateFormatter(type: type)
        return dateFormatter.string(from: self)
    }
    
    subscript(components: Calendar.Component) -> Int {
        Calendar.current.dateComponents([components], from: self).value(for: components)!
    }
    
    func diff(endAt: Date, component: Calendar.Component) -> Int {
        Calendar.current.dateComponents([component], from: self, to: endAt).value(for: component)!
    }
    
    func equals(_ other: Date, components: Set<Calendar.Component>) -> Bool {
        var calendar = Calendar.current
        let selfComponents = calendar.dateComponents(components, from: self)
        let otherComponents = calendar.dateComponents(components, from: other)
        return selfComponents == otherComponents
    }
    
    var range: Range<Int>? {
        let calendar = Calendar.current
        return calendar.range(of: .day, in: .month, for: self)
    }
    
    // self의 month를 기준으로 calendar 생성
    // nil: 이전 month 혹은 다음 month
    var weeks: [[Date?]] {
        let calendar = Calendar.current
        // 해당 월의 첫째 날
        var components = calendar.dateComponents([.year, .month], from: self)
        components.day = 1
        let firstDayOfMonth = calendar.date(from: components)!
        
        // 첫째 날의 요일 (일요일 = 1, 월요일 = 2, ..., 토요일 = 7)
        let firstWeekday = calendar.component(.weekday, from: firstDayOfMonth)
        
        // 날짜 배열 생성
        var days: [Date?] = Array(repeating: nil, count: firstWeekday - 1)
        days += Array(1...(range?.count ?? 0)).compactMap {
            components.day = $0
            return calendar.date(from: components)
        }
        days += Array(repeating: nil, count: (7 - days.count % 7) % 7)
        
        // 주 단위로 배열을 나눔
        return stride(from: 0, to: days.count, by: 7).map {
            Array(days[$0..<$0 + 7])
        }
    }
}
