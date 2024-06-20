import Foundation
import Domain
import SwiftUtil
import DateUtil

struct RoomRes: Decodable, EntityMappable {
    let id: String
    let workspaceId: String
    let type: RoomType
    let roomAdmin: Int
    let chatName: String
    let chatRoomImg: String
    var createdAt: Date
    let chatStatusEnum: ChatStatusEnum
    let joinUserId: [RetrieveMemberRes]
    let lastMessage: String
    let lastMessageTimestamp: Date
    let notReadCnt: Int
    
    func toEntity() -> Room {
        Room(
            id: id,
            workspaceId: workspaceId,
            type: type,
            roomAdmin: roomAdmin,
            chatName: chatName,
            chatRoomImg: chatRoomImg,
            createdAt: createdAt,
            chatStatusEnum: chatStatusEnum,
            joinUserId: joinUserId.map { $0.toEntity() }
        )
    }
}
