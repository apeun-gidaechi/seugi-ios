import Combine
import Domain

final class ChatService: ChatRepo {
    let runner: NetRunner
    
    init(runner: NetRunner) {
        self.runner = runner
    }
    
    func addMemberGroup(_ req: ChatMemberEventReq) -> APIResult<BaseVoid> {
        runner.deepDive(ChatEndpoint.addMemberGroup(req), res: BaseVoid.self)
    }
    
    func kickMemberGroup(_ req: ChatMemberEventReq) -> APIResult<BaseVoid> {
        runner.deepDive(ChatEndpoint.kickMemberGroup(req), res: BaseVoid.self)
    }
    
    func tossMemberGroup(_ req: ChatMemberEventReq) -> APIResult<BaseVoid> {
        runner.deepDive(ChatEndpoint.tossMemberGroup(req), res: BaseVoid.self)
    }
    
    func createGroup(_ req: CreateGroupChatReq) -> APIResult<Base<String>> {
        runner.deepDive(ChatEndpoint.createGroup(req), res: Base<String>.self)
    }
    
    func searchGroup(workspaceId: String, word: String) -> APIResult<Base<[Room]>> {
        runner.deepDive(ChatEndpoint.searchGroupByWord(workspaceId: workspaceId, word: word), res: Base<[Room]>.self)
    }
    
    func searchGroup(roomId: String) -> APIResult<Base<Room>> {
        runner.deepDive(ChatEndpoint.searchGroupById(roomId: roomId), res: Base<Room>.self)
    }
    
    func searchGroup(workspaceId: String) -> APIResult<Base<[Room]>> {
        runner.deepDive(ChatEndpoint.searchGroup(workspaceId: workspaceId), res: Base<[Room]>.self)
    }
    
    func leftGroup(roomId: String) -> APIResult<BaseVoid> {
        runner.deepDive(ChatEndpoint.leftGroup(roomId: roomId), res: BaseVoid.self)
    }
    
    func createPersonal(_ req: CreateGroupChatReq) -> APIResult<Base<String>> {
        runner.deepDive(ChatEndpoint.createPersonal(req), res: Base<String>.self)
    }
    
    func searchPersonal(workspaceId: String, word: String) -> APIResult<Base<[Room]>> {
        runner.deepDive(ChatEndpoint.searchPersonalByWord(workspaceId: workspaceId, word: word), res: Base<[Room]>.self)
    }
    
    func searchPersonal(roomId: String) -> APIResult<Base<Room>> {
        runner.deepDive(ChatEndpoint.searchPersonalById(roomId: roomId), res: Base<Room>.self)
    }
    
    func searchPersonal(workspaceId: String) -> APIResult<Base<[Room]>> {
        runner.deepDive(ChatEndpoint.searchPersonal(workspaceId: workspaceId), res: Base<[Room]>.self)
    }
}
