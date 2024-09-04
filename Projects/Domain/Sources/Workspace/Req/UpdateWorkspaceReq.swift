public struct UpdateWorkspaceReq: Encodable {
    public let workspaceId: String
    public let workspaceName: String
    public let workspaceImgUrl: String
    
    public init(workspaceId: String, workspaceName: String, workspaceImgUrl: String) {
        self.workspaceId = workspaceId
        self.workspaceName = workspaceName
        self.workspaceImgUrl = workspaceImgUrl
    }
}
