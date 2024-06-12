public protocol JoinWorkspaceUseCase {
    func callAsFunction(_ req: JoinWorkspaceRequest) async throws
}
