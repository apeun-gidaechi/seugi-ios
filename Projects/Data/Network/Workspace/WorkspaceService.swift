import Domain

public final class WorkspaceService: Service<WorkspaceEndpoint>, WorkspaceRepo {
    
    public func getWorkspaces() -> APIResult<Base<[Workspace]>> {
        performRequest(.getWorkspaces, res: [WorkspaceRes].self)
    }
    
    public func getWorkspaceCode(workspaceId: String) -> APIResult<Base<String>> {
        performRequest(.getWorkspaceCode(workspaceId: workspaceId), res: String.self)
    }
    
    public func getWorkspace(code: String) -> APIResult<Base<Workspace>> {
        performRequest(.getWorkspace(code: code), res: WorkspaceRes.self)
    }
    
    public func joinWorkspace(workspaceId: String, workspaceCode: String, role: WorkspaceRole) -> APIResult<BaseVoid> {
        performRequest(.joinWorkspace(.init(workspaceId: workspaceId, workspaceCode: workspaceCode, role: role)))
    }
    
    public func getMembers(workspaceId: String) -> APIResult<Base<[RetrieveProfile]>> {
        performRequest(.getMembers(workspaceId: workspaceId), res: [RetrieveProfileRes].self)
    }
}
