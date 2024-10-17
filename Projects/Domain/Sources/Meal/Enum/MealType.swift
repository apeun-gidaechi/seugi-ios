import Foundation
import DateUtil

public enum MealType: String, Entity, Comparable {
    case breakfast = "조식"
    case lunch = "중식"
    case dinner = "석식"
    
    private var priority: Int {
        switch self {
        case .breakfast: 0
        case .lunch: 1
        case .dinner: 2
        }
    }
    
    public static func < (lhs: MealType, rhs: MealType) -> Bool {
        lhs.priority < rhs.priority
    }
    
    public static func from(_ date: Date) -> Self? {
        switch (date[.hour], date[.minute]) {
        case (0...8, _), (8, ..<20):
                .breakfast // 아침: ~ 8:20
        case (8, 21...60), (8...13, _), (13, 0..<30):
                .lunch // 점심: 8:21 ~ 13:30
        case (13, 0...30), (13...19, _), (19, 0..<10):
                .dinner // 저녁: 13:31 ~ 19:10
        default: nil
        }
    }
}
