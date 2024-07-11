import Foundation
import SwiftBok

@Init()
@Members()
public struct Message: Entity {
    public let id: String?
    public let chatRoomId: String
    public let type: `Type`?
    public let userId: Int
    public let message: String
    public let eventList: [Int]?
    public let emoticon: String?
    public let emojiList: [Emoji]
    public let mention: [Int]
    public let mentionAll: Bool
    public let timestamp: Date?
    public let read: [Int]
    public let messageStatus: ChatStatusEnum?
}

public extension [Message] {
    var group: [[Message]] {
        var result: [[Message]] = []
        self
            .sorted { $0.timestamp ?? .now < $1.timestamp ?? .now }
            .forEach { message in
                guard [.message, .deleteMessage].contains(message.type) else {
                    result.append([message])
                    return
                }
                
                if var last = result.last {
                    if last.first?.userId == message.userId {
                        let length = result.count
                        last.append(message)
                        result[length - 1] = last
                    } else {
                        result.append([message])
                    }
                } else {
                    result.append([message])
                }
            }
        return result
    }
}
