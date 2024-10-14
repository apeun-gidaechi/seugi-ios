import SwiftUI
import Domain

extension View {
    func addTimeLabel(alignment: ChatItemHorizontalAlignment, message: Message) -> some View {
        HStack(alignment: .bottom) {
            if alignment == .leading {
                self
            }
            ChatItemTimeLabelView(alignment: alignment, message: message)
            if alignment == .trailing {
                self
            }
        }
    }
}
