public struct CreateWorkspaceReq: Encodable {
    public let workspaceName: String
    public let workspaceImageUrl: String
    
    public init(workspaceName: String, workspaceImageUrl: String) {
        self.workspaceName = workspaceName
        self.workspaceImageUrl = workspaceImageUrl
    }
}
