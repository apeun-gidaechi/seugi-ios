import SwiftUI
import Domain

// ChatItemContainer
// - Has Avatar
// - Horizontal align
struct ChatItemContainer<C: View>: View {
    let type: ChatItemAuthorType
    let message: Message
    @ViewBuilder let content: () -> C
    
    var body: some View {
        HStack(alignment: .top) {
            if case .other = type, message.isFirst {
                SeugiAvatar(message.author?.picture, type: .medium)
            } else if case .bot = type, message.isFirst {
                SeugiAppIcon(type: .medium)
            }
            VStack(alignment: type.alignent.rawValue, spacing: 4) {
                if type.alignent == .leading && message.isFirst,
                   let author = message.author {
                    if type == .bot {
                        Text("캣스기")
                            .font(.body(.b1))
                            .seugiColor(.gray(.g600))
                    } else {
                        Text(author.name)
                            .font(.body(.b1))
                            .seugiColor(.gray(.g600))
                    }
                }
                content()
                    .padding(.leading, !message.isFirst && type.alignent == .leading ? 40 : 0)
            }
        }
        .padding(.top, 8)
        .frame(maxWidth: .infinity, alignment: .init(horizontal: type.alignent.rawValue, vertical: .center))
    }
}
