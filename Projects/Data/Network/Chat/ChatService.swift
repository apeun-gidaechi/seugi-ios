import Domain
import Combine

final class ChatService: Service<ChatEndpoint>, ChatRepo {
    
    func addMemberGroup(_ req: ChatMemberEventReq) -> ObservableResult<BaseVoid> {
        performRequest(.addMemberGroup(req))
    }
    
    func kickMemberGroup(_ req: ChatMemberEventReq) -> ObservableResult<BaseVoid> {
        performRequest(.kickMemberGroup(req))
    }
    
    func tossMemberGroup(_ req: ChatMemberEventReq) -> ObservableResult<BaseVoid> {
        performRequest(.tossMemberGroup(req))
    }
    
    func createGroup(_ req: CreateGroupChatReq) -> ObservableResult<Base<String>> {
        performRequest(.createGroup(req), res: String.self)
    }
    
    func searchGroup(workspaceId: String, word: String) -> ObservableResult<Base<[Room]>> {
        performRequest(.searchGroupByWord(workspaceId: workspaceId, word: word), res: [Room].self)
    }
    
    func searchGroup(roomId: String) -> ObservableResult<Base<Room>> {
        performRequest(.searchGroupById(roomId: roomId), res: Room.self)
    }
    
    func searchGroup(workspaceId: String) -> ObservableResult<Base<[Room]>> {
        performRequest(.searchGroup(workspaceId: workspaceId), res: [Room].self)
    }
    
    func leftGroup(roomId: String) -> ObservableResult<BaseVoid> {
        performRequest(.leftGroup(roomId: roomId))
    }
    
    func createPersonal(_ req: CreateGroupChatReq) -> ObservableResult<Base<String>> {
        performRequest(.createPersonal(req), res: String.self)
    }
    
    func searchPersonal(workspaceId: String, word: String) -> ObservableResult<Base<[Room]>> {
        performRequest(.searchPersonalByWord(workspaceId: workspaceId, word: word), res: [Room].self)
    }
    
    func searchPersonal(roomId: String) -> ObservableResult<Base<Room>> {
        performRequest(.searchPersonalById(roomId: roomId), res: Room.self)
    }
    
    func searchPersonal(workspaceId: String) -> ObservableResult<Base<[Room]>> {
        performRequest(.searchPersonal(workspaceId: workspaceId), res: [Room].self)
    }
}
