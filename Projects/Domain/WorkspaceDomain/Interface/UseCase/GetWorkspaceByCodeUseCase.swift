public protocol GetWorkspaceByCodeUseCase {
    func callAsFunction(code: String) async throws -> Workspace
}
