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
    
    func safeAreaBottomGradientMask() -> some View {
        self
            .padding(.top, 16)
            .background(
                Color.white
                    .mask {
                        VStack(spacing: 0) {
                            LinearGradient(
                                colors: [
                                    .clear,
                                    .black
                                ],
                                startPoint: .top,
                                endPoint: .bottom
                            )
                            Color.black.frame(height: 82)
                        }
                    }
        )
    }
}
