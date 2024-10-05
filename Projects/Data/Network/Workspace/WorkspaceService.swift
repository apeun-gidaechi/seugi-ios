import Domain

final class WorkspaceService: WorkspaceRepo {
    let runner: NetRunner
    
    init(runner: NetRunner) {
        self.runner = runner
    }
    
    func getWorkspaces() -> APIResult<Base<[Workspace]>> {
        runner.deepDive(WorkspaceEndpoint.getWorkspaces, res: Base<[Workspace]>.self)
    }
    
    func getWorkspaceCode(workspaceId: String) -> APIResult<Base<String>> {
        runner.deepDive(WorkspaceEndpoint.getWorkspaceCode(workspaceId: workspaceId), res: Base<String>.self)
    }
    
    func getWorkspace(code: String) -> APIResult<Base<WorkspaceInfo>> {
        runner.deepDive(WorkspaceEndpoint.getWorkspace(code: code), res: Base<WorkspaceInfo>.self)
    }
    
    func joinWorkspace(workspaceId: String, workspaceCode: String, role: WorkspaceRole) -> APIResult<BaseVoid> {
        runner.deepDive(WorkspaceEndpoint.joinWorkspace(.init(workspaceId: workspaceId, workspaceCode: workspaceCode, role: role)), res: BaseVoid.self)
    }
    
    func getMembers(workspaceId: String) -> APIResult<Base<[RetrieveProfile]>> {
        runner.deepDive(WorkspaceEndpoint.getMembers(workspaceId: workspaceId), res: Base<[RetrieveProfile]>.self)
    }
    
    func getMembersChart(workspaceId: String) -> APIResult<Base<WorkspaceMembersChart>> {
        runner.deepDive(WorkspaceEndpoint.getMembersChart(workspaceId: workspaceId), res: Base<WorkspaceMembersChart>.self)
    }
    
    func createWorkspace(workspaceName: String, workspaceImageUrl: String) -> APIResult<BaseVoid> {
        runner.deepDive(WorkspaceEndpoint.createWorkspace(.init(workspaceName: workspaceName, workspaceImageUrl: workspaceImageUrl)), res: BaseVoid.self)
    }
    
    func removeWorkspace(workspaceId: String) -> APIResult<BaseVoid> {
        runner.deepDive(WorkspaceEndpoint.removeWorkspace(workspaceId: workspaceId), res: BaseVoid.self)
    }
    
    func addWorkspace(workspaceId: String, userSet: [Int], role: WorkspaceRole) -> APIResult<BaseVoid> {
        runner.deepDive(WorkspaceEndpoint.addWorkspace(.init(workspaceId: workspaceId, userSet: userSet, role: role)), res: BaseVoid.self)
    }
    
    func cancelWorkspace(workspaceId: String, userSet: [Int], role: WorkspaceRole) -> APIResult<BaseVoid> {
        runner.deepDive(WorkspaceEndpoint.cancelWorkspace(.init(workspaceId: workspaceId, userSet: userSet, role: role)), res: BaseVoid.self)
    }
    
    func getWaitList(workspaceId: String, workspaceRole: WorkspaceRole) -> APIResult<Base<[RetrieveMember]>> {
        runner.deepDive(WorkspaceEndpoint.getWaitList(workspaceId: workspaceId, workspaceRole: workspaceRole), res: Base<[RetrieveMember]>.self)
    }
    
    func updateWorkspace(workspaceId: String, workspaceName: String, workspaceImageUrl: String) -> APIResult<BaseVoid> {
        runner.deepDive(WorkspaceEndpoint.updateWorkspace(.init(workspaceId: workspaceId, workspaceName: workspaceName, workspaceImgUrl: workspaceImageUrl)), res: BaseVoid.self)
    }
    
    func getMyWaitList() -> APIResult<Base<[WorkspaceInfo]>> {
        runner.deepDive(WorkspaceEndpoint.getMyWaitList, res: Base<[WorkspaceInfo]>.self)
    }
}
