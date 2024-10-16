import SwiftUI
import Domain

struct ChatItemTimeLabelView: View {
    private let alignment: ChatItemHorizontalAlignment
    private let message: Message
    
    init(
        alignment: ChatItemHorizontalAlignment,
        message: Message
    ) {
        self.alignment = alignment
        self.message = message
    }
    
    var body: some View {
        if message.hasTimeLabel {
            VStack(
                alignment: alignment.rawValue,
                spacing: 0
            ) {
                if message.unread > 0 {
                    Text("\(message.unread)")
                        .seugiColor(.gray(.g600))
                        .font(.caption(.c1))
                }
                if let text = message.timestamp?.prettyText {
                    Text(text)
                        .seugiColor(.gray(.g600))
                        .font(.caption(.c2))
                }
            }
        }
    }
}
