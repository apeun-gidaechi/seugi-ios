public protocol OutJoinedUseCase {
    func callAsFunction(_ req: OutJoinedRequest) async throws
}
