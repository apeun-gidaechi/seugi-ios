public protocol AddJoinedUseCase {
    func callAsFunction(_ req: AddJoinedRequest) async throws -> AddJoined
}
