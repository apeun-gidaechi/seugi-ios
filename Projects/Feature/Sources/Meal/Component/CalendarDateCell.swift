import SwiftUI
import Component

struct CalendarDateCell: View {
    private let date: Date?
    private let selected: Bool
    
    init(date: Date?, selected: Bool) {
        self.date = date
        self.selected = selected
    }
    
    private var label: String {
        guard let date else {
            return ""
        }
        let day = date[.day]
        return "\(day)"
    }
    
    var body: some View {
        Text(label)
            .font(.subtitle(.s2))
            .seugiColor(
                selected
                ? .sub(.white)
                : .gray(.g600)
            )
            .padding(.vertical, 8)
            .background {
                if selected {
                    Rectangle()
                        .seugiColor(.primary(.p500))
                        .cornerRadius(12, corners: .allCorners)
                        .frame(width: 36, height: 36)
                }
            }
            .frame(maxWidth: .infinity)
            .opacity(date == nil ? 0 : 1)
    }
}
