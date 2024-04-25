import Foundation

/**
 자신이 속한 채팅방 모두 불러오기
 */
public struct Chat {
    public let id: Int
    public let type: RoomType?
    public let chatName: String
    public let containUserCnt: Int
    public let createdAt: Date
    public let chatStatusEnum: ChatStatus?
    
    public init(
        id: Int,
        type: RoomType?,
        chatName: String,
        containUserCnt: Int,
        createdAt: Date,
        chatStatusEnum: ChatStatus?
    ) {
        self.id = id
        self.type = type
        self.chatName = chatName
        self.containUserCnt = containUserCnt
        self.createdAt = createdAt
        self.chatStatusEnum = chatStatusEnum
    }
}

public enum ChatStatus: String, RawRepresentable {
    case ALIVE
    case DELETE
}

public enum RoomType: String, RawRepresentable {
    case PERSONAL
    case GROUP
}
