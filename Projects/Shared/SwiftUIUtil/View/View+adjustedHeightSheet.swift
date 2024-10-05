import SwiftUI

struct AdjustedHeightSheetViewModifier: ViewModifier {
    
    @State private var size: CGSize = .zero
    
    func body(content: Content) -> some View {
        content
            .onReadSize {
                self.size = $0
            }
            .presentationDetents([.height(size.height)])
    }
}

public extension View {
    func adjustedHeightSheet() -> some View {
        self.modifier(AdjustedHeightSheetViewModifier())
    }
}
