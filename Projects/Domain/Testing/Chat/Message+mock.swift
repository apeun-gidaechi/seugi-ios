import Domain

extension Message: Mock {
    public static func mock() -> Message {
        Message(
            id: .randomUUID(),
            chatRoomId: .randomUUID(),
            type: .message,
            userId: .randomId(),
            message: .randomUUID(),
            eventList: [],
            emoticon: nil,
            emojiList: [],
            mention: [],
            mentionAll: false,
            timestamp: .now,
            read: [1, 2],
            messageStatus: .alive
        )
    }
}
