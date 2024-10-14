import SwiftUI

struct AdjustedHeightSheetViewModifier: ViewModifier {
    
    @State private var size: CGSize = .zero
    private let minHeight: CGFloat?
    private let maxHeight: CGFloat?
    
    init(minHeight: CGFloat?, maxHeight: CGFloat?) {
        self.minHeight = minHeight
        self.maxHeight = maxHeight
    }
    
    private var height: CGFloat {
        var height = size.height
        if let minHeight {
            height = max(minHeight, height)
        }
        if let maxHeight {
            height = min(maxHeight, height)
        }
        return height
    }
    
    func body(content: Content) -> some View {
        content
            .onReadSize {
                size = $0
            }
            .presentationDetents([.height(height)])
    }
}

public extension View {
    func adjustedHeightSheet(minHeight: CGFloat? = nil, maxHeight: CGFloat? = nil) -> some View {
        self.modifier(
            AdjustedHeightSheetViewModifier(
                minHeight: minHeight,
                maxHeight: maxHeight
            )
        )
    }
}
