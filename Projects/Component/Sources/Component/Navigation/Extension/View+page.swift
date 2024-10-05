import SwiftUI

public extension View {
    func page(icon: SeugiIconography, hasBadge: Bool = false) -> Page {
        Page(icon: icon, hasBadge: hasBadge) { self }
    }
}
