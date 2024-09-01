//
//  LocalRoom.swift
//  Core
//
//  Created by hhhello0507 on 9/1/24.
//  Copyright © 2024 apeun-gidaechi. All rights reserved.
//

import Foundation
import RealmSwift
import Domain

class LocalRoom: Object, ObjectKeyIdentifiable {
    
    @Persisted(primaryKey: true) var id: String
    @Persisted var workspaceId: String
    @Persisted var type: RoomType
    @Persisted var roomAdmin: Int
    @Persisted var chatName: String
    @Persisted var chatRoomImg: String?
    @Persisted var createdAt: Date?
    @Persisted var chatStatusEnum: ChatStatusEnum
    @Persisted var joinUserId: RealmSwift.List<LocalRetrieveMember>
    @Persisted var lastMessage: String
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
        joinUserId: [LocalRetrieveMember],
        lastMessage: String,
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
    
    static func of(workspaceId: String, room: Room) -> LocalRoom {
        return LocalRoom(
            id: room.id,
            workspaceId: workspaceId,
            type: room.type,
            roomAdmin: room.roomAdmin,
            chatName: room.chatName,
            chatRoomImg: room.chatRoomImg,
            createdAt: room.createdAt,
            chatStatusEnum: room.chatStatusEnum,
            joinUserId: room.joinUserId.map { LocalRetrieveMember.of(member: $0) },
            lastMessage: room.lastMessage,
            lastMessageTimestamp: room.lastMessageTimestamp,
            notReadCnt: room.notReadCnt
        )
    }
    
    func toRoom() -> Room {
        Room(
            id: self.id,
            workspaceId: self.workspaceId,
            type: self.type,
            roomAdmin: self.roomAdmin,
            chatName: self.chatName,
            chatRoomImg: self.chatRoomImg,
            createdAt: self.createdAt,
            chatStatusEnum: self.chatStatusEnum,
            joinUserId: Array(self.joinUserId).map { $0.toRetrieveMember() },
            lastMessage: self.lastMessage,
            lastMessageTimestamp: self.lastMessageTimestamp,
            notReadCnt: self.notReadCnt
        )
    }
}
