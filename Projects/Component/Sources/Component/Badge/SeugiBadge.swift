import SwiftUI
import SwiftUIUtil

public struct SeugiBadge: View {
    private let type: SeugiBadgeType
    
    public init(type: SeugiBadgeType) {
        self.type = type
    }
    
    public var body: some View {
        if case let .number(num) = type {
            let text = num >= 300 ? "300+" : String(num)
            Text(text)
                .font(.caption(.c2))
                .frame(height: type.size)
                .padding(.horizontal, 8)
                .background(Color.seugi(.orange(.o500)))
                .cornerRadius(type.size / 2, corners: .allCorners)
                .seugiColor(.sub(.white))
        } else {
            Circle()
                .seugiColor(.orange(.o500))
                .frame(height: type.size)
        }
    }
}
