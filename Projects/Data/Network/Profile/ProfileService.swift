import Domain
import Combine
import SwiftUtil

final class ProfileService: Service<ProfileEndpoint>, ProfileRepo {
    func me(workspaceId: String) -> APIResult<Base<RetrieveProfile>> {
        performRequest(.me(workspaceId: workspaceId), res: RetrieveProfileRes.self)
    }
    
    func others(workspaceId: String, memberId: String) -> APIResult<Base<RetrieveProfile>> {
        performRequest(.others(workspaceId: workspaceId, memberId: memberId), res: RetrieveProfileRes.self)
    }
}
