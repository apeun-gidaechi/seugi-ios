//  Author: hhhello0507
//  Created: 10/10/24


import SwiftUI
import WidgetKit
import Domain
import Component

public struct MealWidgetEntryView: View {
    @Environment(\.widgetFamily) private var widgetFamily
    private let entry: MealEntry
    
    public init(
        entry: MealEntry
    ) {
        self.entry = entry
    }
    
    public var body: some View {
        let mealType = MealType.from(.now) ?? .breakfast
        let meal = entry.meal
        VStack(spacing: 4) {
            HStack(spacing: 0) {
                Text(mealType.rawValue)
                    .seugiColor(.sub(.white))
                    .padding(.horizontal, 10)
                    .padding(.vertical, 4)
                    .seugiBackground(.primary(.p500))
                    .cornerRadius(14, corners: .allCorners)
                    .font(.footnote)
                Spacer()
                if let meal {
                    Text(meal.calorie)
                        .font(.caption)
                        .seugiColor(.gray(.g600))
                }
            }
            VStack(alignment: .leading, spacing: 0) {
                if let meal {
                    if meal.menu.isEmpty {
                        MealMenuText(text: "오늘은\n급식이 없어요", isMealEmpty: true)
                    } else {
                        HStack(spacing: 8) {
                            if widgetFamily == .systemSmall {
                                VStack(alignment: .leading, spacing: 0) {
                                    ForEach(0..<min(meal.menu.count, 6), id: \.self) { idx in
                                        MealMenuText(
                                            text: String(meal.menu.count > 6 && idx == 6 ? "..." : meal.menu[idx].split(separator: " ").first ?? "")
                                        )
                                    }
                                }
                            } else {
                                ForEach(Array.from(meal.menu.splitArray(position: 6)), id: \.self) { meals in
                                    VStack(alignment: .leading, spacing: 0) {
                                        ForEach(meals, id: \.self) { meal in
                                            MealMenuText(text: String(meal.split(separator: " ").first ?? ""))
                                        }
                                    }
                                }
                            }
                        }
                    }
                } else {
                    MealMenuText(text: "급식을\n불러올 수 없어요", isMealEmpty: true)
                }
            }
            .padding(8)
            .frame(maxHeight: .infinity)
            .seugiBackground(.gray(.g200))
            .cornerRadius(18, corners: .allCorners)
            .shadow(.evBlack(.ev2))
        }
        .padding(8)
        .seugiBackground(.gray(.g100))
    }
}
