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
                    if case .group = type {
                        Text(String(room.joinUserId.count))
                            .font(.body(.b2))
                            .seugiColor(.gray(.g500))
                    }
                }
                Text("나 사실...") // TODO: Dummy
                    .font(.body(.b2))
                    .seugiColor(.gray(.g600))
            }
            Spacer()
            VStack(spacing: 4) {
                Text("12:39") // TODO: Dummy
                    .font(.body(.b2))
                    .seugiColor(.gray(.g500))
                if case .group = type,
                   !room.joinUserId.isEmpty {
                    SeugiBadge(type: .number(room.joinUserId.count))
                }
            }
        }
        .background(Color.seugi(.sub(.white)))
        .padding(.horizontal, 16)
        .padding(.vertical, 16)
    }
}
