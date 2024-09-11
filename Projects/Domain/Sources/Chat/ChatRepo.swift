import Combine

public protocol ChatRepo {
    
    // MemberGroup
    func addMemberGroup(_ req: ChatMemberEventReq) -> ObservableResult<BaseVoid>
    func kickMemberGroup(_ req: ChatMemberEventReq) -> ObservableResult<BaseVoid>
    func tossMemberGroup(_ req: ChatMemberEventReq) -> ObservableResult<BaseVoid>
    
    // Group
    func createGroup(_ req: CreateGroupChatReq) -> ObservableResult<Base<String>>
    func searchGroup(workspaceId: String, word: String) -> ObservableResult<Base<[Room]>>
    func searchGroup(roomId: String) -> ObservableResult<Base<Room>>
    func searchGroup(workspaceId: String) -> ObservableResult<Base<[Room]>>
    func leftGroup(roomId: String) -> ObservableResult<BaseVoid>
    
    // Personal
    func createPersonal(_ req: CreateGroupChatReq) -> ObservableResult<Base<String>>
    func searchPersonal(workspaceId: String, word: String) -> ObservableResult<Base<[Room]>>
    func searchPersonal(roomId: String) -> ObservableResult<Base<Room>>
    func searchPersonal(workspaceId: String) -> ObservableResult<Base<[Room]>>
}
