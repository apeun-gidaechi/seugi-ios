import SwiftUI

public extension View {
    
    @inlinable
    func content<Content: View>(
        @ViewBuilder content: @escaping (Self) -> Content
    ) -> some View {
        return content(self)
    }
    
    @inlinable
    @ViewBuilder
    func `if`<Content: View>(
        _ condition: Bool,
        transform: (Self) -> Content
    ) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
    
    @inlinable
    @ViewBuilder
    func `if`<Content: View>(
        _ condition: Bool,
        then trueTransform: (Self) -> Content,
        else falseTransform: (Self) -> Content
    ) -> some View {
        if condition {
            trueTransform(self)
        } else {
            falseTransform(self)
        }
    }
}
