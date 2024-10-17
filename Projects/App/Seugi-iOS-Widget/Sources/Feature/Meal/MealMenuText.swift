import SwiftUI
import Component

struct MealMenuText: View {
    
    let text: String
    let isMealEmpty: Bool
    
    init(text: String, isMealEmpty: Bool = false) {
        self.text = text
        self.isMealEmpty = isMealEmpty
    }
    
    var body: some View {
        VStack {
            if isMealEmpty {
                Text(text)
                    .font(.footnote)
                    .multilineTextAlignment(.center)
                    .seugiColor(.sub(.black))
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            } else {
                Text(text)
                    .lineLimit(1)
                    .truncationMode(.tail)
                    .font(.caption)
                    .seugiColor(.sub(.black))
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
}

#Preview {
    MealMenuText(text: "test", isMealEmpty: true)
}
