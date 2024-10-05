import SwiftUI

import SwiftUIUtil

public struct SeugiCategory: View {
    private static let categoryHeight: CGFloat = 34
    
    private let text: String
    private let isSelected: Bool
    private let action: () -> Void
    
    public init(
        text: String,
        isSelected: Bool,
        action: @escaping () -> Void
    ) {
        self.text = text
        self.isSelected = isSelected
        self.action = action
    }
    
    public var body: some View {
        let backgroundColor: Color = isSelected ? .seugi(.primary(.p500)) : .seugi(.gray(.g100))
        Button(action: action) {
            Text(text)
                .font(.subtitle(.s2))
                .frame(height: Self.categoryHeight)
                .padding(.horizontal, 16)
                .seugiColor(isSelected ? .sub(.white) : .gray(.g500))
                .background(backgroundColor)
                .cornerRadius(Self.categoryHeight / 2, corners: .allCorners)
        }
        .scaledButtonStyle()
    }
}
