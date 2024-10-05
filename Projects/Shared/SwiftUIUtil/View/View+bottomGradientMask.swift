import SwiftUI

public extension View {
    func bottomGradientMask(
        height: CGFloat = 120
    ) -> some View {
        self.mask(alignment: .bottom) {
            VStack(spacing: 0) {
                Color.black
                LinearGradient(
                    colors: [.black, .clear],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .frame(height: height)
            }
            .ignoresSafeArea()
        }
    }
}
