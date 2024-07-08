import SwiftBok
import Foundation

@Init()
@Members()
public struct Room: Entity, Hashable {
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
    public let joinUserId: [RetrieveMember]
}

public extension Room {
    func findUserById(id: Int) -> RetrieveMember? {
        self.joinUserId.first {
            $0.id == id
        }
    }
}
