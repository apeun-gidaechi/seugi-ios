public struct FetchSchedulesForMonthReq: Encodable {
    public let workspaceId: String
    public let month: Int
    
    public init(workspaceId: String, month: Int) {
        self.workspaceId = workspaceId
        self.month = month
    }
}
