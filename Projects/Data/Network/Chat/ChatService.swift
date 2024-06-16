import Domain
import Combine
import SwiftUtil

final class ChatService: Service<ChatEndpoint>, ChatRepo {
    
    func addMemberGroup(chatRoomId: String?, chatMemberUsers: [Int]) -> APIResult<BaseVoid> {
        performRequest(.addMemberGroup(.init(chatRoomId: chatRoomId, chatMemberUsers: chatMemberUsers)))
    }
    
    func kickMemberGroup(chatRoomId: String?, chatMemberUsers: [Int]) -> APIResult<BaseVoid> {
        performRequest(.kickMemberGroup(.init(chatRoomId: chatRoomId, chatMemberUsers: chatMemberUsers)))
    }
    
    func tossMemberGroup(chatRoomId: String?, chatMemberUsers: [Int]) -> APIResult<BaseVoid> {
        performRequest(.tossMemberGroup(.init(chatRoomId: chatRoomId, chatMemberUsers: chatMemberUsers)))
    }
    
    func createGroup(roomName: String, workspaceId: String, joinUsers: [Int], chatRoomImg: String) -> APIResult<Base<String>> {
        performRequest(.createGroup(.init(roomName: roomName, workspaceId: workspaceId, joinUsers: joinUsers, chatRoomImg: chatRoomImg)), res: String.self)
    }
    
    func searchGroup(workspaceId: String, word: String) -> APIResult<Base<[Room]>> {
        performRequest(.searchGroupByWord(workspaceId: workspaceId, word: word), res: [RoomRes].self)
    }
    
    func searchGroup(roomId: String) -> APIResult<Base<Room>> {
        performRequest(.searchGroupById(roomId: roomId), res: RoomRes.self)
    }
    
    func searchGroup(workspaceId: String) -> APIResult<Base<[Room]>> {
        performRequest(.searchGroup(workspaceId: workspaceId), res: [RoomRes].self)
    }
    
    func leftGroup(roomId: String) -> APIResult<BaseVoid> {
        performRequest(.leftGroup(roomId: roomId))
    }
    
    func createPersonal(roomName: String, workspaceId: String, joinUsers: [Int], chatRoomImg: String) -> APIResult<Base<String>> {
        performRequest(.createPersonal(.init(roomName: roomName, workspaceId: workspaceId, joinUsers: joinUsers, chatRoomImg: chatRoomImg)), res: String.self)
    }
    
    func searchPersonal(workspaceId: String, word: String) -> APIResult<Base<[Room]>> {
        performRequest(.searchPersonalByWord(workspaceId: workspaceId, word: word), res: [RoomRes].self)
    }
    
    func searchPersonal(roomId: String) -> APIResult<Base<Room>> {
        performRequest(.searchPersonalById(roomId: roomId), res: RoomRes.self)
    }
    
    func searchPersonal(workspaceId: String) -> APIResult<Base<[Room]>> {
        performRequest(.searchPersonal(workspaceId: workspaceId), res: [RoomRes].self)
    }
}
