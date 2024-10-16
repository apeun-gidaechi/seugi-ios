import SwiftUI
import Component
import Domain

struct HomeMealContainerCell: View {
    private let meal: Meal
    
    init(for meal: Meal) {
        self.meal = meal
    }
    
    var body: some View {
        VStack(spacing: 8) {
            HStack {
                Text(meal.mealType.rawValue)
                    .font(.caption(.c1))
                    .padding(.horizontal, 10)
                    .seugiColor(.sub(.white))
                    .frame(height: 24)
                    .seugiBackground(.primary(.p500))
                    .cornerRadius(12, corners: .allCorners)
                Spacer()
                Text(meal.calorie)
                    .font(.caption(.c1))
                    .seugiColor(.gray(.g500))
            }
            VStack(spacing: 0) {
                ForEach(meal.menu.indices, id: \.self) { index in
                    Text(meal.menu[index])
                        .font(.body(.b2))
                        .seugiColor(.gray(.g700))
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
        }
    }
}
