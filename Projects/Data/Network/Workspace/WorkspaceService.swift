import Domain

final class WorkspaceService: Service<WorkspaceEndpoint>, WorkspaceRepo {
    
    func getWorkspaces() -> APIResult<Base<[Workspace]>> {
        performRequest(.getWorkspaces, res: [WorkspaceRes].self)
    }
    
    func getWorkspaceCode(workspaceId: String) -> APIResult<Base<String>> {
        performRequest(.getWorkspaceCode(workspaceId: workspaceId), res: String.self)
    }
    
    func getWorkspace(code: String) -> APIResult<Base<WorkspaceInfo>> {
        performRequest(.getWorkspace(code: code), res: WorkspaceInfoRes.self)
    }
    
    func joinWorkspace(workspaceId: String, workspaceCode: String, role: WorkspaceRole) -> APIResult<BaseVoid> {
        performRequest(.joinWorkspace(.init(workspaceId: workspaceId, workspaceCode: workspaceCode, role: role)))
    }
    
    func getMembers(workspaceId: String) -> APIResult<Base<[RetrieveProfile]>> {
        performRequest(.getMembers(workspaceId: workspaceId), res: [RetrieveProfileRes].self)
    }
    
    func getMembersChart(workspaceId: String) -> APIResult<Base<WorkspaceMembersChart>> {
        performRequest(.getMembersChart(workspaceId: workspaceId), res: WorkspaceMembersChartRes.self)
    }
    
    func createWorkspace(workspaceName: String, workspaceImageUrl: String) -> APIResult<BaseVoid> {
        performRequest(.createWorkspace(.init(workspaceName: workspaceName, workspaceImageUrl: workspaceImageUrl)))
    }
    
    func removeWorkspace(workspaceId: String) -> APIResult<BaseVoid> {
        performRequest(.removeWorkspace(workspaceId: workspaceId))
    }
    
    func addWorkspace(workspaceId: String, userSet: [Int], role: WorkspaceRole) -> APIResult<BaseVoid> {
        performRequest(.addWorkspace(.init(workspaceId: workspaceId, userSet: userSet, role: role)))
    }
    
    func cancelWorkspace(workspaceId: String, userSet: [Int], role: WorkspaceRole) -> APIResult<BaseVoid> {
        performRequest(.cancelWorkspace(.init(workspaceId: workspaceId, userSet: userSet, role: role)))
    }
    
    func getWaitList(workspaceId: String, workspaceRole: WorkspaceRole) -> APIResult<Base<[RetrieveMember]>> {
        performRequest(.getWaitList(workspaceId: workspaceId, workspaceRole: workspaceRole), res: [RetrieveMemberRes].self)
    }
    
    func updateWorkspace(workspaceId: String, workspaceName: String, workspaceImageUrl: String) -> APIResult<BaseVoid> {
        performRequest(.updateWorkspace(.init(workspaceId: workspaceId, workspaceName: workspaceName, workspaceImgUrl: workspaceImageUrl)))
    }
    
    func getMyWaitList() -> APIResult<Base<[WorkspaceInfo]>> {
        performRequest(.getMyWaitList, res: [WorkspaceInfoRes].self)
    }
}
