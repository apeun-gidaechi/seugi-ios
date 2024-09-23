import Domain

public final class FakeChatRepo: ChatRepo {
    
    public init() {}
    public func addMemberGroup(_ req: ChatMemberEventReq) -> ObservableResult<BaseVoid> {
        BaseVoid.mock().successResult
    }
    
    public func kickMemberGroup(_ req: ChatMemberEventReq) -> ObservableResult<BaseVoid> {
        BaseVoid.mock().successResult
    }
    
    public func tossMemberGroup(_ req: ChatMemberEventReq) -> ObservableResult<BaseVoid> {
        BaseVoid.mock().successResult
    }
    
    public func createGroup(_ req: CreateGroupChatReq) -> ObservableResult<Base<String>> {
        "success".successBaseResult
    }
    
    public func searchGroup(workspaceId: String, word: String) -> ObservableResult<Base<[Room]>> {
        (0..<3).map { _ in Room.mock() }.successBaseResult
    }
    
    public func searchGroup(roomId: String) -> ObservableResult<Base<Room>> {
        Room.mock().successBaseResult
    }
    
    public func searchGroup(workspaceId: String) -> ObservableResult<Base<[Room]>> {
        (0..<10).map { _ in Room.mock() }.successBaseResult
    }
    
    public func leftGroup(roomId: String) -> ObservableResult<BaseVoid> {
        BaseVoid.mock().successResult
    }
    
    public func createPersonal(_ req: CreateGroupChatReq) -> ObservableResult<Base<String>> {
        "success".successBaseResult
    }
    
    public func searchPersonal(workspaceId: String, word: String) -> ObservableResult<Base<[Room]>> {
        (0..<10).map { _ in Room.mock() }.successBaseResult
    }
    
    public func searchPersonal(roomId: String) -> ObservableResult<Base<Room>> {
        Room.mock().successBaseResult
    }
    
    public func searchPersonal(workspaceId: String) -> ObservableResult<Base<[Room]>> {
        (0..<100).map { _ in Room.mock() }.successBaseResult
    }
}
