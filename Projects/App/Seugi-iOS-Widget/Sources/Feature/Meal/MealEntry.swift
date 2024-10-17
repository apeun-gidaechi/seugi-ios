import WidgetKit
import Domain

public struct MealEntry: TimelineEntry {
    public let date: Date
    public let meal: Meal?
}

extension MealEntry {
    static let empty = MealEntry(
        date: .now,
        meal: .empty
    )
    
    static func of(_ date: Date) -> MealEntry {
        MealEntry(
            date: date,
            meal: nil
        )
    }
}

extension Meal {
    static let empty = Meal(
        id: 1,
        workspaceId: "",
        mealType: .breakfast,
        menu: [
            "참치야채죽 (5.6)", "*슈가와플 (1.2.5.6)",
            "별카츠/소스 (1.2.5.6.13.15)", "배추김치 (9)",
            "*고래밥시리얼+우유 (2.5.6)"
        ],
        calorie: "778.8 Kcal",
        mealInfo: [
            "쇠고기(종류) : 국내산(한우)",
            "쇠고기 식육가공품 : 국내산","돼지고기 : 국내산","돼지고기 식육가공품 : 국내산","닭고기 : 국내산","닭고기 식육가공품 : 국내산",
            "오리고기 : 국내산","오리고기 가공품 : 국내산","쌀 : 국내산","배추 : 국내산","고춧가루 : 국내산","콩 : 국내산",
            "낙지 : 국내산","고등어 : 국내산","갈치 : 국내산","오징어 : 국내산","꽃게 : 국내산","참조기 : 국내산","비고 : "
        ],
        mealDate: .now
    )
}
