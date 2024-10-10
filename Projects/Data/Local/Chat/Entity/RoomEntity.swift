import Foundation

import Domain

import RealmSwift

class RoomEntity: Object {
    @Persisted(primaryKey: true) var id: String
    @Persisted var workspaceId: String
    @Persisted var type: RoomType
    @Persisted var roomAdmin: Int
    @Persisted var chatName: String
    @Persisted var chatRoomImg: String?
    @Persisted var createdAt: Date?
    @Persisted var chatStatusEnum: ChatStatusEnum
    @Persisted var joinUserId: List<UserInfoEntity>
    @Persisted var lastMessage: String?
    @Persisted var lastMessageTimestamp: Date
    @Persisted var notReadCnt: Int
    
    convenience init(
        id: String,
        workspaceId: String,
        type: RoomType,
        roomAdmin: Int,
        chatName: String,
        chatRoomImg: String? = nil,
        createdAt: Date? = nil,
        chatStatusEnum: ChatStatusEnum,
        joinUserId: [UserInfoEntity],
        lastMessage: String?,
        lastMessageTimestamp: Date,
        notReadCnt: Int
    ) {
        self.init()
        self.id = id
        self.workspaceId = workspaceId
        self.type = type
        self.roomAdmin = roomAdmin
        self.chatName = chatName
        self.chatRoomImg = chatRoomImg
        self.createdAt = createdAt
        self.chatStatusEnum = chatStatusEnum
        self.joinUserId.append(objectsIn: joinUserId)
        self.lastMessage = lastMessage
        self.lastMessageTimestamp = lastMessageTimestamp
        self.notReadCnt = notReadCnt
    }
    
    static func of(workspaceId: String, room: Room) -> RoomEntity {
        return RoomEntity(
            id: room.id,
            workspaceId: workspaceId,
            type: room.type,
            roomAdmin: room.roomAdmin,
            chatName: room.chatName,
            chatRoomImg: room.chatRoomImg,
            createdAt: room.createdAt,
            chatStatusEnum: room.chatStatusEnum,
            joinUserId: room.joinUserId.map { UserInfoEntity.of($0) },
            lastMessage: room.lastMessage,
            lastMessageTimestamp: room.lastMessageTimestamp,
            notReadCnt: room.notReadCnt
        )
    }
    
    func toDomain() -> Room {
        Room(
            id: self.id,
            workspaceId: self.workspaceId,
            type: self.type,
            roomAdmin: self.roomAdmin,
            chatName: self.chatName,
            chatRoomImg: self.chatRoomImg,
            createdAt: self.createdAt,
            chatStatusEnum: self.chatStatusEnum,
            joinUserId: self.joinUserId.map { $0.toDomain() },
            lastMessage: self.lastMessage,
            lastMessageTimestamp: self.lastMessageTimestamp,
            notReadCnt: self.notReadCnt
        )
    }
}
