import Domain

extension GetMessage: Mock {
    public static func mock() -> GetMessage {
        .init(
            firstMessageId: .randomUUID(),
            messages: [
                .mock(),
                .mock(),
                .mock()
            ]
        )
    }
}
