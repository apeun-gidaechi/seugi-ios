public protocol GetJoinedUseCase {
    func callAsFunction(roomId: Int) async throws -> Joined
}
