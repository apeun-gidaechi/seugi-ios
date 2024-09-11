import Domain

final class WorkspaceService: Service<WorkspaceEndpoint>, WorkspaceRepo {
    
    func getWorkspaces() -> ObservableResult<Base<[Workspace]>> {
        performRequest(.getWorkspaces, res: [Workspace].self)
    }
    
    func getWorkspaceCode(workspaceId: String) -> ObservableResult<Base<String>> {
        performRequest(.getWorkspaceCode(workspaceId: workspaceId), res: String.self)
    }
    
    func getWorkspace(code: String) -> ObservableResult<Base<WorkspaceInfo>> {
        performRequest(.getWorkspace(code: code), res: WorkspaceInfo.self)
    }
    
    func joinWorkspace(workspaceId: String, workspaceCode: String, role: WorkspaceRole) -> ObservableResult<BaseVoid> {
        performRequest(.joinWorkspace(.init(workspaceId: workspaceId, workspaceCode: workspaceCode, role: role)))
    }
    
    func getMembers(workspaceId: String) -> ObservableResult<Base<[RetrieveProfile]>> {
        performRequest(.getMembers(workspaceId: workspaceId), res: [RetrieveProfile].self)
    }
    
    func getMembersChart(workspaceId: String) -> ObservableResult<Base<WorkspaceMembersChart>> {
        performRequest(.getMembersChart(workspaceId: workspaceId), res: WorkspaceMembersChart.self)
    }
    
    func createWorkspace(workspaceName: String, workspaceImageUrl: String) -> ObservableResult<BaseVoid> {
        performRequest(.createWorkspace(.init(workspaceName: workspaceName, workspaceImageUrl: workspaceImageUrl)))
    }
    
    func removeWorkspace(workspaceId: String) -> ObservableResult<BaseVoid> {
        performRequest(.removeWorkspace(workspaceId: workspaceId))
    }
    
    func addWorkspace(workspaceId: String, userSet: [Int], role: WorkspaceRole) -> ObservableResult<BaseVoid> {
        performRequest(.addWorkspace(.init(workspaceId: workspaceId, userSet: userSet, role: role)))
    }
    
    func cancelWorkspace(workspaceId: String, userSet: [Int], role: WorkspaceRole) -> ObservableResult<BaseVoid> {
        performRequest(.cancelWorkspace(.init(workspaceId: workspaceId, userSet: userSet, role: role)))
    }
    
    func getWaitList(workspaceId: String, workspaceRole: WorkspaceRole) -> ObservableResult<Base<[RetrieveMember]>> {
        performRequest(.getWaitList(workspaceId: workspaceId, workspaceRole: workspaceRole), res: [RetrieveMember].self)
    }
    
    func updateWorkspace(workspaceId: String, workspaceName: String, workspaceImageUrl: String) -> ObservableResult<BaseVoid> {
        performRequest(.updateWorkspace(.init(workspaceId: workspaceId, workspaceName: workspaceName, workspaceImgUrl: workspaceImageUrl)))
    }
    
    func getMyWaitList() -> ObservableResult<Base<[WorkspaceInfo]>> {
        performRequest(.getMyWaitList, res: [WorkspaceInfo].self)
    }
}
