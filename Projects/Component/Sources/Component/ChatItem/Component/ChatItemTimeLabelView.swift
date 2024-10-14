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
    
    private var unreadUserCount: Int {
//        config.joinUserCount - config.message.read.count
        0 // TODO: FIXFIXFIXFIXFIXFIXFIXFIXFIXFIXFIXFIXFIXFIXFIXFIX
    }
    
    var body: some View {
        if message.isLast {
            VStack(alignment: alignment.rawValue, spacing: 0) {
                if unreadUserCount > 0 {
                    Text("\(unreadUserCount)")
                        .seugiColor(.gray(.g600))
                        .font(.caption(.c1))
                }
                Text(message.timestamp?.prettyText ?? "")
                    .seugiColor(.gray(.g600))
                    .font(.caption(.c2))
            }
        }
    }
}
