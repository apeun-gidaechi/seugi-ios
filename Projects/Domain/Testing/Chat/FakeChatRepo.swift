import Domain

public final class FakeChatRepo: ChatRepo {
    public init() {}
    public func addMemberGroup(chatRoomId: String?, chatMemberUsers: [Int]) -> APIResult<BaseVoid> {
        BaseVoid.mock().successResult
    }
    
    public func kickMemberGroup(chatRoomId: String?, chatMemberUsers: [Int]) -> APIResult<BaseVoid> {
        BaseVoid.mock().successResult
    }
    
    public func tossMemberGroup(chatRoomId: String?, chatMemberUsers: [Int]) -> APIResult<BaseVoid> {
        BaseVoid.mock().successResult
    }
    
    public func createGroup(roomName: String, workspaceId: String, joinUsers: [Int], chatRoomImg: String) -> APIResult<Base<String>> {
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
    
    public func createPersonal(roomName: String, workspaceId: String, joinUsers: [Int], chatRoomImg: String) -> APIResult<Base<String>> {
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
