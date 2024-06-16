import Domain

public final class WorkspaceService: Service, WorkspaceRepo {
    typealias Target = WorkspaceEndpoint
    
    public func getWorkspaces() -> APIResult<Base<[Workspace]>> {
        request(.getWorkspaces, res: BaseRes<[WorkspaceRes]>.self)
            .map { $0.toEntity() }
            .asResult()
    }
    
    public func getWorkspaceCode(workspaceId: String) -> APIResult<Base<String>> {
        request(.getWorkspaceCode(workspaceId: workspaceId), res: BaseRes<String>.self)
            .map { $0.toEntity() }
            .asResult()
    }
    
    public func getWorkspace(code: String) -> APIResult<Base<Workspace>> {
        request(.getWorkspace(code: code), res: BaseRes<WorkspaceRes>.self)
            .map { $0.toEntity() }
            .asResult()
    }
    
    public func joinWorkspace(workspaceId: String, workspaceCode: String, role: WorkspaceRole) -> APIResult<BaseVoid> {
        request(.joinWorkspace(.init(workspaceId: workspaceId, workspaceCode: workspaceCode, role: role)))
            .map { $0.toEntity() }
            .asResult()
    }
}
