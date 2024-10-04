import Domain

public final class FakeChatRepo: ChatRepo {
    
    public init() {}
    public func addMemberGroup(_ req: ChatMemberEventReq) -> APIResult<BaseVoid> {
        BaseVoid.mock().successResult
    }
    
    public func kickMemberGroup(_ req: ChatMemberEventReq) -> APIResult<BaseVoid> {
        BaseVoid.mock().successResult
    }
    
    public func tossMemberGroup(_ req: ChatMemberEventReq) -> APIResult<BaseVoid> {
        BaseVoid.mock().successResult
    }
    
    public func createGroup(_ req: CreateGroupChatReq) -> APIResult<Base<String>> {
        "success".successBaseResult
    }
    
    public func searchGroup(workspaceId: String, word: String) -> APIResult<Base<[Room]>> {
        (0..<3).map { _ in Room.mock() }.successBaseResult
    }
    
    public func searchGroup(roomId: String) -> APIResult<Base<Room>> {
        Room.mock().successBaseResult
    }
    
    public func searchGroup(workspaceId: String) -> APIResult<Base<[Room]>> {
        (0..<10).map { _ in Room.mock() }.successBaseResult
    }
    
    public func leftGroup(roomId: String) -> APIResult<BaseVoid> {
        BaseVoid.mock().successResult
    }
    
    public func createPersonal(_ req: CreateGroupChatReq) -> APIResult<Base<String>> {
        "success".successBaseResult
    }
    
    public func searchPersonal(workspaceId: String, word: String) -> APIResult<Base<[Room]>> {
        (0..<10).map { _ in Room.mock() }.successBaseResult
    }
    
    public func searchPersonal(roomId: String) -> APIResult<Base<Room>> {
        Room.mock().successBaseResult
    }
    
    public func searchPersonal(workspaceId: String) -> APIResult<Base<[Room]>> {
        (0..<100).map { _ in Room.mock() }.successBaseResult
    }
}
