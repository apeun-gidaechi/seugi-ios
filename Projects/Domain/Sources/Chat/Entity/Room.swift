import Foundation

public struct Room: Entity {
    public static func == (lhs: Room, rhs: Room) -> Bool {
        lhs.id == rhs.id
    }
    
    public let id: String
    public let workspaceId: String
    public let type: RoomType
    public let roomAdmin: Int
    public let chatName: String
    public let chatRoomImg: String?
    public let createdAt: Date?
    public let chatStatusEnum: ChatStatusEnum
    public let joinUserId: [UserInfo]
    public let lastMessage: String?
    public let lastMessageTimestamp: Date
    public let notReadCnt: Int
    
    public init(
        id: String,
        workspaceId: String,
        type: RoomType,
        roomAdmin: Int,
        chatName: String,
        chatRoomImg: String?,
        createdAt: Date?,
        chatStatusEnum: ChatStatusEnum,
        joinUserId: [UserInfo],
        lastMessage: String?,
        lastMessageTimestamp: Date,
        notReadCnt: Int
    ) {
        self.id = id
        self.workspaceId = workspaceId
        self.type = type
        self.roomAdmin = roomAdmin
        self.chatName = chatName
        self.chatRoomImg = chatRoomImg
        self.createdAt = createdAt
        self.chatStatusEnum = chatStatusEnum
        self.joinUserId = joinUserId
        self.lastMessage = lastMessage
        self.lastMessageTimestamp = lastMessageTimestamp
        self.notReadCnt = notReadCnt
    }
}

public extension Room {
    func findUser(id: Int) -> UserInfo? {
        self.joinUserId.first {
            $0.userInfo.id == id
        }
    }
    
    func findUserOrUnknownUser(id: Int) -> UserInfo {
        findUser(id: id) ?? .init(userInfo: .invalidMember(id: id), timestamp: .now)
    }
}
