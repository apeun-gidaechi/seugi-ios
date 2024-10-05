import SwiftUI

extension View {
    func addTimeLabel(alignment: ChatItemHorizontalAlignment, config: ChatItemConfig) -> some View {
        HStack(alignment: .bottom) {
            if alignment == .leading {
                self
            }
            ChatItemTimeLabelView(alignment: alignment, config: config)
            if alignment == .trailing {
                self
            }
        }
    }
}
