import Combine

public protocol ChatRepo {
    // MemberGroup
    func addMemberGroup(chatRoomId: String?, chatMemberUsers: [Int]) -> APIResult<BaseVoid>
    func kickMemberGroup(chatRoomId: String?, chatMemberUsers: [Int]) -> APIResult<BaseVoid>
    func tossMemberGroup(chatRoomId: String?, chatMemberUsers: [Int]) -> APIResult<BaseVoid>
    
    // Group
    func createGroup(roomName: String, workspaceId: String, joinUsers: [Int], chatRoomImg: String) -> APIResult<Base<String>>
    func searchGroup(workspaceId: String, word: String) -> APIResult<Base<[Room]>>
    func searchGroup(roomId: String) -> APIResult<Base<Room>>
    func searchGroup(workspaceId: String) -> APIResult<Base<[Room]>>
    func leftGroup(roomId: String) -> APIResult<BaseVoid>
    
    // Personal
    func createPersonal(roomName: String, workspaceId: String, joinUsers: [Int], chatRoomImg: String) -> APIResult<Base<String>>
    func searchPersonal(workspaceId: String, word: String) -> APIResult<Base<[Room]>>
    func searchPersonal(roomId: String) -> APIResult<Base<Room>>
    func searchPersonal(workspaceId: String) -> APIResult<Base<[Room]>>
}
