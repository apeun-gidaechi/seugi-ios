import Domain

extension Message: Mock {
    public static func mock() -> Message {
        Message(
            id: "",
            chatRoomId: "",
            type: .message,
            userId: 0,
            message: "wow 하이하이",
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
