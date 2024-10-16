import Foundation

public struct Room: Entity {
    public static func == (lhs: Room, rhs: Room) -> Bool {
        lhs.id == rhs.id
    }
    
    public let id: String
    public let workspaceId: String
    public var type: RoomType
    public var roomAdmin: Int
    public var chatName: String
    public var chatRoomImg: String?
    public var createdAt: Date?
    public var chatStatusEnum: ChatStatusEnum
    public var joinUserInfo: [UserInfo]
    public var lastMessage: String?
    public var lastMessageTimestamp: Date
    public var notReadCnt: Int
    
    public init(
        id: String,
        workspaceId: String,
        type: RoomType,
        roomAdmin: Int,
        chatName: String,
        chatRoomImg: String?,
        createdAt: Date?,
        chatStatusEnum: ChatStatusEnum,
        joinUserInfo: [UserInfo],
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
        self.joinUserInfo = joinUserInfo
        self.lastMessage = lastMessage
        self.lastMessageTimestamp = lastMessageTimestamp
        self.notReadCnt = notReadCnt
    }
}

public extension Room {
    func findUser(id: Int) -> UserInfo? {
        self.joinUserInfo.first {
            $0.userInfo.id == id
        }
    }
    
    func findUserOrUnknownUser(id: Int) -> UserInfo {
        findUser(id: id) ?? .init(userInfo: .invalidMember(id: id), timestamp: .now)
    }
}

extension Room: Searchable {
    public var searchString: String {
        self.chatName
    }
}

public extension [Room] {
    func setupOnline(userId: Int) -> [Room] {
        var rooms = self
        for (i, room) in rooms.enumerated() {
            for (j, userInfo) in room.joinUserInfo.enumerated() {
                if userInfo.userInfo.id == userId {
                    rooms[i].joinUserInfo[j].timestamp = .distantPast
                }
            }
        }
        return self
    }
}
