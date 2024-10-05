import SwiftUI

struct ChatItemTimeLabelView: View {
    private let alignment: ChatItemHorizontalAlignment
    private let config: ChatItemConfig
    
    init(alignment: ChatItemHorizontalAlignment, config: ChatItemConfig) {
        self.alignment = alignment
        self.config = config
    }
    private var unreadUserCount: Int {
        config.joinUserCount - config.message.read.count
    }
    
    var body: some View {
        if config.isLast {
            VStack(alignment: alignment.rawValue, spacing: 0) {
                if unreadUserCount > 0 {
                    Text("\(unreadUserCount)")
                        .seugiColor(.gray(.g600))
                        .font(.caption(.c1))
                }
                Text(config.message.timestamp?.adjustedString ?? "")
                    .seugiColor(.gray(.g600))
                    .font(.caption(.c2))
            }
        }
    }
}
