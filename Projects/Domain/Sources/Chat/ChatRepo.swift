public protocol ChatRepo {
    
    // MemberGroup
    func addMemberGroup(_ req: ChatMemberEventReq) -> APIResult<BaseVoid>
    func kickMemberGroup(_ req: ChatMemberEventReq) -> APIResult<BaseVoid>
    func tossMemberGroup(_ req: ChatMemberEventReq) -> APIResult<BaseVoid>
    
    // Group
    func createGroup(_ req: CreateGroupChatReq) -> APIResult<Base<String>>
    func searchGroup(workspaceId: String, word: String) -> APIResult<Base<[Room]>>
    func searchGroup(roomId: String) -> APIResult<Base<Room>>
    func searchGroup(workspaceId: String) -> APIResult<Base<[Room]>>
    func leftGroup(roomId: String) -> APIResult<BaseVoid>
    
    // Personal
    func createPersonal(_ req: CreateGroupChatReq) -> APIResult<Base<String>>
    func searchPersonal(workspaceId: String, word: String) -> APIResult<Base<[Room]>>
    func searchPersonal(roomId: String) -> APIResult<Base<Room>>
    func searchPersonal(workspaceId: String) -> APIResult<Base<[Room]>>
}
