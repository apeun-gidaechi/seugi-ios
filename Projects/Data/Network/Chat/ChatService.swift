import Domain
import Combine
import SwiftUtil

final class ChatService: Service, ChatRepo {
    typealias Target = ChatEndpoint
    
    func addMemberGroup(chatRoomId: String?, chatMemberUsers: [Int]) -> APIResult<BaseVoid> {
        request(.addMemberGroup(.init(chatRoomId: chatRoomId, chatMemberUsers: chatMemberUsers)))
            .map { $0.toEntity() }
            .asResult()
    }
    
    func kickMemberGroup(chatRoomId: String?, chatMemberUsers: [Int]) -> APIResult<BaseVoid> {
        request(.kickMemberGroup(.init(chatRoomId: chatRoomId, chatMemberUsers: chatMemberUsers)))
            .map { $0.toEntity() }
            .asResult()
    }
    
    func tossMemberGroup(chatRoomId: String?, chatMemberUsers: [Int]) -> APIResult<BaseVoid> {
        request(.tossMemberGroup(.init(chatRoomId: chatRoomId, chatMemberUsers: chatMemberUsers)))
            .map { $0.toEntity() }
            .asResult()
    }
    
    func createGroup(roomName: String, workspaceId: String, joinUsers: [Int], chatRoomImg: String) -> APIResult<Base<String>> {
        request(.createGroup(.init(roomName: roomName, workspaceId: workspaceId, joinUsers: joinUsers, chatRoomImg: chatRoomImg)), res: BaseRes<String>.self)
            .map { $0.toEntity() }
            .asResult()
    }
    
    func searchGroup(workspaceId: String, word: String) -> APIResult<Base<[Room]>> {
        request(.searchGroupByWord(workspaceId: workspaceId, word: word), res: BaseRes<[RoomRes]>.self)
            .map { $0.toEntity() }
            .asResult()
    }
    
    func searchGroup(roomId: String) -> APIResult<Base<Room>> {
        request(.searchGroupById(roomId: roomId), res: BaseRes<RoomRes>.self)
            .map { $0.toEntity() }
            .asResult()
    }
    
    func searchGroup(workspaceId: String) -> APIResult<Base<[Room]>> {
        request(.searchGroup(workspaceId: workspaceId), res: BaseRes<[RoomRes]>.self)
            .map { $0.toEntity() }
            .asResult()
    }
    
    func leftGroup(roomId: String) -> APIResult<BaseVoid> {
        request(.leftGroup(roomId: roomId))
            .map { $0.toEntity() }
            .asResult()
    }
    
    func createPersonal(roomName: String, workspaceId: String, joinUsers: [Int], chatRoomImg: String) -> APIResult<Base<String>> {
        request(.createPersonal(.init(roomName: roomName, workspaceId: workspaceId, joinUsers: joinUsers, chatRoomImg: chatRoomImg)), res: BaseRes<String>.self)
            .map { $0.toEntity() }
            .asResult()
    }
    
    func searchPersonal(workspaceId: String, word: String) -> APIResult<Base<[Room]>> {
        request(.searchPersonalByWord(workspaceId: workspaceId, word: word), res: BaseRes<[RoomRes]>.self)
            .map { $0.toEntity() }
            .asResult()
    }
    
    func searchPersonal(roomId: String) -> APIResult<Base<Room>> {
        request(.searchPersonalById(roomId: roomId), res: BaseRes<RoomRes>.self)
            .map { $0.toEntity() }
            .asResult()
    }
    
    func searchPersonal(workspaceId: String) -> APIResult<Base<[Room]>> {
        request(.searchPersonal(workspaceId: workspaceId), res: BaseRes<[RoomRes]>.self)
            .map { $0.toEntity() }
            .asResult()
    }
}
