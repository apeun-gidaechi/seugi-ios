import Domain

extension Room: Mock {
    public static func mock() -> Room {
        Room(
            id: .randomUUID(),
            workspaceId: .randomUUID(),
            type: .group,
            roomAdmin: .randomId(),
            chatName: "노영재와재와",
            chatRoomImg: "",
            createdAt: .now,
            chatStatusEnum: .alive,
            joinUserId: (0..<10).map { _ in .mock() },
            lastMessage: "wow",
            lastMessageTimestamp: .now,
            notReadCnt: 10
        )
    }
}
