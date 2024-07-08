import SwiftUI
import Domain
import DateUtil

public struct ChatItemView: View {
    
    private let author: RetrieveMember
    private let messages: [Message]
    private let type: ChatItemViewCellType
    private let joinedUserCount: Int
    
    public init(
        author: RetrieveMember,
        messages: [Message],
        type: ChatItemViewCellType,
        joinedUserCount: Int
    ) {
        self.author = author
        self.messages = messages
        self.type = type
        self.joinedUserCount = joinedUserCount
    }
    
    public var body: some View {
        HStack {
            if case .me = type {
                Spacer()
            }
            HStack(alignment: .top) {
                if case .other = type {
                    SeugiAvatar(author.picture, type: .medium)
                } else if case .ai = type {
                    SeugiAppIcon(type: .medium)
                }
                VStack(alignment: .leading, spacing: 4) {
                    if type.isLeft {
                        Text(author.name)
                            .font(.body(.b1))
                            .seugiColor(.gray(.g600))
                    }
                    VStack(alignment: type.isLeft ? .leading : .trailing, spacing: 8) {
                        ForEach(Array(messages.enumerated()), id: \.element.id) { idx, message in
                            // 마지막 뷰 일때
                            ChatItemViewCell(text: message.message, type: type)
                                .if(idx == messages.count - 1) { view in
                                    HStack(alignment: .bottom) {
                                        if type.isLeft {
                                            view
                                        }
                                        VStack(alignment: type.isLeft ? .leading : .trailing, spacing: 0) {
                                            let unreadUserCount = joinedUserCount - message.read.count
                                            if unreadUserCount > 0 {
                                                Text("\(unreadUserCount)")
                                                    .seugiColor(.gray(.g600))
                                                    .font(.caption(.c1))
                                            }
                                            Text(message.timestamp?.localeHHSS ?? "")
                                                .seugiColor(.gray(.g600))
                                                .font(.caption(.c2))
                                        }
                                        if !type.isLeft {
                                            view
                                        }
                                    }
                                }
                        }
                    }
                }
            }
            .padding()
            if type.isLeft {
                Spacer()
            }
        }
    }
}
