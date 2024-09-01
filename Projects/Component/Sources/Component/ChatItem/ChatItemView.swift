import SwiftUI
import Domain
import DateUtil
import SwiftUIUtil

public struct ChatItemView: View {
    
    private let author: RetrieveMember
    private let message: Message
    private let type: ChatItemViewCellType
    private let joinedUserCount: Int
    
    public init(
        author: RetrieveMember,
        message: Message,
        type: ChatItemViewCellType,
        joinedUserCount: Int
    ) {
        self.author = author
        self.message = message
        self.type = type
        self.joinedUserCount = joinedUserCount
    }
    
    private var isFirst: Bool {
        switch type {
        case .other(let isFirst, _) where isFirst,
                .ai(let isFirst, _) where isFirst:
            true
        default:
            false
        }
    }
    
    public var body: some View {
        HStack(alignment: .top) {
            if case .other(let isFirst, _) = type,
               isFirst {
                SeugiAvatar(author.picture, type: .medium)
            } else if case .ai(let isFirst, _) = type, isFirst {
                SeugiAppIcon(type: .medium)
            }
            VStack(alignment: type.isLeft ? .leading : .trailing, spacing: 4) {
                // MARK: - author
                if type.isLeft {
                    if isFirst {
                        Text(author.name)
                            .font(.body(.b1))
                            .seugiColor(.gray(.g600))
                    }
                }
                // MARK: - Chat
                Group {
                    switch type {
                    case .other(_, let isLast) where isLast,
                            .ai(_, let isLast) where isLast:
                        HStack(alignment: .bottom) {
                            if type.isLeft {
                                chat
                            }
                            VStack(alignment: type.isLeft ? .leading : .trailing, spacing: 0) {
                                let unreadUserCount = joinedUserCount - message.read.count
                                if unreadUserCount > 0 {
                                    Text("\(unreadUserCount)")
                                        .seugiColor(.gray(.g600))
                                        .font(.caption(.c1))
                                }
                                Text(message.timestamp?.adjustedString ?? "")
                                    .seugiColor(.gray(.g600))
                                    .font(.caption(.c2))
                            }
                            if !type.isLeft {
                                chat
                            }
                        }
                    default:
                        chat
                    }
                }
                .if(!isFirst) {
                    $0.padding(.leading, 40)
                }
            }
        }
        .padding(.horizontal, 8)
        .padding(.top, 8)
        .if(type.isLeft) {
            $0.toLeading()
        }
        .if(!type.isLeft) {
            $0.toTrailing()
        }
    }
    
    @ViewBuilder
    private var chat: some View {
        ChatItemViewCell(text: message.message, type: type)
    }
}
