import SwiftUI

public extension View {

    func stroke<Content>(_ radius: CGFloat, corners: UIRectCorner = .allCorners, content: Content, lineWidth: CGFloat = 1) -> some View where Content: ShapeStyle {
        let roundedCorner = RoundedCornerShape(radius: radius, corners: corners)
        return self
            .clipShape(roundedCorner)
            .overlay {
                roundedCorner
                    .stroke(content, lineWidth: lineWidth)
            }
    }
}
