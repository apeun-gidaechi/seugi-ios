import SwiftUI

struct CustomScrollView<C: View>: View {
    private let alignment: HorizontalAlignment
    private let spacing: CGFloat?
    private let reversed: Bool
    private let content: () -> C
    
    init(
        alignment: HorizontalAlignment = .center,
        spacing: CGFloat? = nil,
        reversed: Bool = false,
        @ViewBuilder content: @escaping () -> C
    ) {
        self.alignment = alignment
        self.spacing = spacing
        self.reversed = reversed
        self.content = content
    }
    
    var body: some View {
        if reversed {
            ScrollView {
                LazyVStack(
                    alignment: alignment,
                    spacing: spacing
                ) {
                    content()
                }
                .rotationEffect(Angle(degrees: 180))
                .scaleEffect(x: -1.0, y: 1.0, anchor: .center)
            }
            .rotationEffect(Angle(degrees: 180))
            .scaleEffect(x: -1.0, y: 1.0, anchor: .center)
        } else {
            ScrollView {
                LazyVStack(
                    alignment: alignment,
                    spacing: spacing,
                    content: content
                )
            }
        }
    }
}
