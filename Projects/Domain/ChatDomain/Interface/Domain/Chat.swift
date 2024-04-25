import Foundation

/**
 자신이 속한 채팅방 모두 불러오기
 */
public struct Chat {
    let id: Int
    let type: String
    let chatName: String
    let containUserCnt: Int
    let createdAt: Date
    let chatStatusEnum: String
}

public enum ChatStatus: String, RawRepresentable {
    case ALIVE
    case DELETE
}

public enum RoomType: String, RawRepresentable {
    case PERSONAL
    case GROUP
}
