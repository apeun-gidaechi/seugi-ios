import SwiftUI

public extension View {
    
    @ViewBuilder
    func shimmer(_ condition: Bool = true) -> some View {
        if condition {
            Shimmer { self }
        } else {
            self
        }
    }
}
