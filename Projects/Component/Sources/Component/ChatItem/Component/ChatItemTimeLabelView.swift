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
        VStack(
            alignment: alignment.rawValue,
            spacing: 0
        ) {
            if message.unread > 0 {
                Text("\(message.unread)")
                    .seugiColor(.gray(.g600))
                    .font(.caption(.c1))
            }
            if message.hasTimeLabel,
               let text = message.timestamp?.parseString("a hh:mm") {
                Text(text)
                    .seugiColor(.gray(.g600))
                    .font(.caption(.c2))
            }
        }
    }
}
