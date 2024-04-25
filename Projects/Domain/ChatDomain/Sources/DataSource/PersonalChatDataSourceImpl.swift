import ChatDomainInterface
import BaseDomainInterface

final class PersonalChatDataSourceImpl: PersonalChatDataSource, RemoteProtocol {
    
    typealias Target = PersonalChatTarget
    
    func createGroupChat(_ req: CreateChatRequest) async throws -> Int {
        try await request(target: .createPersonal(req))
            .map(BaseResponse<Int>.self, using: decoder).data
    }
    
    func getGroupChat(workspaceId: Int) async throws -> [Chat] {
        try await request(target: .getPersonalChat(workspaceId: workspaceId))
            .map(BaseResponse<[ChatResponse]>.self, using: decoder).data.map { $0.toDomain() }
    }
}
