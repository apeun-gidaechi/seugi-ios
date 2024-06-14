import SwiftUI

struct OverflowContentViewModifier: ViewModifier {
    @State private var contentOverflow = false
    private let height: CGFloat?
    
    init(
        height: CGFloat?
    ) {
        self.height = height
    }
    
    func body(content: Content) -> some View {
        GeometryReader { geometry in
            content
            .background(
                GeometryReader { contentGeometry in
                    Color.clear.onAppear {
                        if let height {
                            contentOverflow = contentGeometry.size.height > height
                        } else {
                            contentOverflow = contentGeometry.size.height > geometry.size.height
                        }
                    }
                }
            )
            .wrappedInScrollView(when: contentOverflow)
        }
    }
}

extension View {
    @ViewBuilder
    func wrappedInScrollView(when condition: Bool) -> some View {
        if condition {
            ScrollView {
                self
            }
        } else {
            self
        }
    }
}

public extension View {
    func scrollOnOverflow(_ height: CGFloat?) -> some View {
        modifier(OverflowContentViewModifier(height: height))
    }
}
