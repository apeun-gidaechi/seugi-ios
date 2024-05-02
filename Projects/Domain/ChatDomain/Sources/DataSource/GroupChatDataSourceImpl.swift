import ChatDomainInterface
import BaseDomainInterface

final class GroupChatDataSourceImpl: GroupChatDataSource, RemoteProtocol {
    typealias Target = GroupChatTarget
    
    func createGroupChat(_ req: CreateChatRequest) async throws -> Int {
        try await request(target: .createGroup(req))
            .map(BaseResponse<Int>.self, using: decoder).data
    }
    
    func getGroupChat(workspaceId: Int) async throws -> [Chat] {
        try await request(target: .getGroupChat(workspaceId: workspaceId))
            .map(BaseResponse<[ChatResponse]>.self, using: decoder).data.map { $0.toDomain() }
    }
    
    func addJoined(_ req: AddJoinedRequest) async throws -> AddJoined {
        try await request(target: .addJoined(req))
            .map(BaseResponse<AddJoinedResponse>.self, using: decoder).data.toDomain()
    }
    
    func getJoined(roomId: Int) async throws -> Joined {
        try await request(target: .getJoined(roomId: roomId))
            .map(BaseResponse<JoinedResponse>.self, using: decoder).data.toDomain()
    }
    
    func outJoined(_ req: OutJoinedRequest) async throws {
        _ = try await request(target: .outJoined(req))
            .map(BaseVoidResponse.self, using: decoder)
    }
}
