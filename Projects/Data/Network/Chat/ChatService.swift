import Combine

import Domain

final class ChatService: Service<ChatEndpoint>, ChatRepo {
    func addMemberGroup(_ req: ChatMemberEventReq) -> APIResult<BaseVoid> {
        performRequest(.addMemberGroup(req))
    }
    
    func kickMemberGroup(_ req: ChatMemberEventReq) -> APIResult<BaseVoid> {
        performRequest(.kickMemberGroup(req))
    }
    
    func tossMemberGroup(_ req: ChatMemberEventReq) -> APIResult<BaseVoid> {
        performRequest(.tossMemberGroup(req))
    }
    
    func createGroup(_ req: CreateGroupChatReq) -> APIResult<Base<String>> {
        performRequest(.createGroup(req), res: String.self)
    }
    
    func searchGroup(workspaceId: String, word: String) -> APIResult<Base<[Room]>> {
        performRequest(.searchGroupByWord(workspaceId: workspaceId, word: word), res: [Room].self)
    }
    
    func searchGroup(roomId: String) -> APIResult<Base<Room>> {
        performRequest(.searchGroupById(roomId: roomId), res: Room.self)
    }
    
    func searchGroup(workspaceId: String) -> APIResult<Base<[Room]>> {
        performRequest(.searchGroup(workspaceId: workspaceId), res: [Room].self)
    }
    
    func leftGroup(roomId: String) -> APIResult<BaseVoid> {
        performRequest(.leftGroup(roomId: roomId))
    }
    
    func createPersonal(_ req: CreateGroupChatReq) -> APIResult<Base<String>> {
        performRequest(.createPersonal(req), res: String.self)
    }
    
    func searchPersonal(workspaceId: String, word: String) -> APIResult<Base<[Room]>> {
        performRequest(.searchPersonalByWord(workspaceId: workspaceId, word: word), res: [Room].self)
    }
    
    func searchPersonal(roomId: String) -> APIResult<Base<Room>> {
        performRequest(.searchPersonalById(roomId: roomId), res: Room.self)
    }
    
    func searchPersonal(workspaceId: String) -> APIResult<Base<[Room]>> {
        performRequest(.searchPersonal(workspaceId: workspaceId), res: [Room].self)
    }
}
