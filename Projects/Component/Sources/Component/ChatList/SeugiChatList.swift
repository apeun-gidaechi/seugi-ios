import SwiftUI

import Domain

public struct SeugiChatList: View {
    private let type: RoomType
    private let room: Room
    
    public init(
        type: RoomType = .personal,
        room: Room
    ) {
        self.type = type
        self.room = room
    }
    
    public var body: some View {
        HStack(spacing: 16) {
            SeugiAvatar(type: .large)
            VStack(alignment: .leading, spacing: 2) {
                HStack(alignment: .bottom, spacing: 4) {
                    Text(room.chatName)
                        .font(.subtitle(.s2))
                        .seugiColor(.sub(.black))
                        .lineLimit(1)
                    if case .group = type {
                        Text(String(room.joinUserId.count))
                            .font(.body(.b2))
                            .seugiColor(.gray(.g500))
                    }
                }
                if let lastMessage = room.lastMessage {
                    Text(lastMessage)
                        .font(.body(.b2))
                        .seugiColor(.gray(.g600))
                        .lineLimit(1)
                }
            }
            Spacer()
            VStack(alignment: .trailing, spacing: 4) {
                Text(room.lastMessageTimestamp.adjustedString)
                    .font(.body(.b2))
                    .seugiColor(.gray(.g500))
                if room.notReadCnt > 0 {
                    SeugiBadge(type: .number(room.notReadCnt))
                }
            }
        }
        .background(Color.seugi(.sub(.white)))
        .padding(.horizontal, 16)
        .padding(.vertical, 16)
    }
}
