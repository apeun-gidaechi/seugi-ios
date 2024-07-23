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
    
    public func createWorkspace(workspaceName: String, workspaceImageUrl: String) -> APIResult<BaseVoid> {
        performRequest(.createWorkspace(.init(workspaceName: workspaceName, workspaceImageUrl: workspaceImageUrl)))
    }
    
    public func removeWorkspace(workspaceId: String) -> APIResult<BaseVoid> {
        performRequest(.removeWorkspace(workspaceId: workspaceId))
    }
    
    public func approveJoinWorkspace(workspaceId: String, approvalUserSer: [Int], role: WorkspaceRole) -> APIResult<BaseVoid> {
        performRequest(.approveJoinWorkspace(.init(workspaceId: workspaceId, approvalUserSet: approvalUserSer, role: role)))
    }
    
    public func getWaitList(workspaceId: String, workspaceRole: WorkspaceRole) -> APIResult<Base<[Int]>> {
        performRequest(.getWaitList(workspaceId: workspaceId, workspaceRole: workspaceRole), res: [Int].self)
    }
    
    public func updateWorkspace(workspaceId: String, workspaceName: String, workspaceImageUrl: String) -> APIResult<BaseVoid> {
        performRequest(.updateWorkspace(.init(workspaceId: workspaceId, workspaceName: workspaceName, workspaceImgUrl: workspaceImageUrl)))
    }
    
    public func getMyWaitList() -> APIResult<Base<[Workspace]>> {
        performRequest(.getMyWaitList, res: [WorkspaceRes].self)
    }
}
