import SwiftUI
import Component
import Domain

struct MealCell: View {
    private let meal: Meal
    
    init(meal: Meal) {
        self.meal = meal
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Text(meal.mealType.rawValue)
                    .font(.subtitle(.s2))
                    .seugiColor(.sub(.black))
                Spacer()
                Text(meal.calorie)
                    .font(.body(.b2))
                    .seugiColor(.gray(.g600))
            }
            ForEach(meal.menu.indices, id: \.self) { index in
                let menu = meal.menu[index]
                Text(menu)
                    .font(.body(.b2))
                    .seugiColor(.sub(.black))
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .padding(.vertical, 16)
    }
}
