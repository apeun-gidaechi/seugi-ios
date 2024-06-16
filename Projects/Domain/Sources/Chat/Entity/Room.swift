import PublicInit
import Foundation

@PublicInit
public struct Room: Entity, Equatable {
    public static func == (lhs: Room, rhs: Room) -> Bool {
        lhs.id == rhs.id
    }
    
    public let id: String
    public let workspaceId: String
    public let type: RoomType
    public let roomAdmin: Int
    public let chatName: String
    public let chatRoomImg: String
    public let createdAt: Date?
    public let chatStatusEnum: ChatStatusEnum
    public let joinUserId: [RetrieveMember]
}
