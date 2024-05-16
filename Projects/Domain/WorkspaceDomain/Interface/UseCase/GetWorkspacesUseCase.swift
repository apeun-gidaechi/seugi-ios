public protocol GetWorkspacesUseCase {
    func callAsFunction() async throws -> [Workspace]
}
