public protocol CreateGroupChatUseCase {
    func callAsFunction(_ req: CreateGroupRequest) async throws -> Int
}
