import SwiftUI

struct AdjustedHeightSheetViewModifier: ViewModifier {
    
    @State private var size: CGSize = .zero
    
    func body(content: Content) -> some View {
        if #available(iOS 18.0, *) {
            content
                .presentationSizing(.form)
        } else {
            content
                .onReadSize {
                    size = $0
                }
                .presentationDetents([.height(size.height)])
        }
    }
}

public extension View {
    func adjustedHeightSheet() -> some View {
        self.modifier(AdjustedHeightSheetViewModifier())
    }
}
