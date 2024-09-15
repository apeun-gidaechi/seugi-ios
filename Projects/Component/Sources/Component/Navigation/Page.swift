import SwiftUI

public struct Page {
    public let content: AnyView
    public let icon: SeugiIconography
    public let hasBadge: Bool
    
    @resultBuilder
    public struct Builder {
        public static func buildBlock(
            _ components: Page...
        ) -> [Page] {
            components
        }
    }
    
    public init<C: View>(
        icon: SeugiIconography,
        hasBadge: Bool,
        @ViewBuilder content: @escaping () -> C
    ) {
        self.icon = icon
        self.hasBadge = hasBadge
        self.content = AnyView(content())
    }
}
