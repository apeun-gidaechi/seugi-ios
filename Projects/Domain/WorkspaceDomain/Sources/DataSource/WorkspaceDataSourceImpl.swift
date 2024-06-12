import WorkspaceDomainInterface
import BaseDomainInterface

final class WorkspaceDataSourceImpl: RemoteProtocol, WorkspaceDataSource {
    typealias Target = WorkspaceTarget
    
    func getWorkspaces() async throws -> [Workspace] {
        try await request(target: .getWorkspaces)
            .map(BaseResponse<[WorkspaceResponse]>.self, using: decoder).data.map { $0.toDomain() }
    }
    
    func getWorkspaceByCode(code: String) async throws -> Workspace {
        try await request(target: .getWorkspaceByCode(code: code))
            .map(BaseResponse<WorkspaceResponse>.self, using: decoder).data.toDomain()
    }
    
    func joinWorkspace(_ req: JoinWorkspaceRequest) async throws {
        try await request(target: .joinWorkspace(req))
    }
}
