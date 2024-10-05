import SwiftUI

struct AdjustFrameViewModifier: ViewModifier {
    
    @State private var size: CGSize?
    
    let minWidth: CGFloat
    let maxWidth: CGFloat
    let minHeight: CGFloat
    let maxHeight: CGFloat
    
    private var calcedSize: CGSize? {
        guard let size else { return nil }
        
        // init value
        var width = size.width
        var height = size.height
        
        if width > maxWidth {
            height *= maxWidth / width
            width = maxWidth
        }
        
        if height > maxHeight {
            width *= maxHeight / height
            height = maxHeight
        }
        
        return CGSize(width: max(minWidth, width), height: max(minHeight, height))
    }
    
    func body(content: Content) -> some View {
        content.onReadSize { size in
            self.size = size
        }
        .frame(width: calcedSize?.width, height: calcedSize?.height)
    }
}

public extension View {
    func adjustFrame(minWidth: CGFloat, maxWidth: CGFloat, minHeight: CGFloat, maxHeight: CGFloat) -> some View {
        self.aspectRatio(contentMode: .fit)
            .modifier(AdjustFrameViewModifier(minWidth: minWidth, maxWidth: maxWidth, minHeight: minHeight, maxHeight: maxHeight))
    }
}
