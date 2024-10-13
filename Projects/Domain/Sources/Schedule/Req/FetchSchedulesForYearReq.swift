public struct FetchSchedulesForYearReq: Encodable {
    public let workspaceId: String
    
    public init(workspaceId: String) {
        self.workspaceId = workspaceId
    }
}
