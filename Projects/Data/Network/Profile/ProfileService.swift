import Domain
import Combine

final class ProfileService: Service<ProfileEndpoint>, ProfileRepo {
    func me(workspaceId: String) -> APIResult<Base<RetrieveProfile>> {
        performRequest(.me(workspaceId: workspaceId), res: RetrieveProfileRes.self)
    }
    
    func others(workspaceId: String, memberId: String) -> APIResult<Base<RetrieveProfile>> {
        performRequest(.others(workspaceId: workspaceId, memberId: memberId), res: RetrieveProfileRes.self)
    }
    
    func patchProfile(workspaceId: String, status: String, nick: String, spot: String, belong: String, phone: String, wire: String, location: String) -> APIResult<BaseVoid> {
        performRequest(
            .patch(
                workspaceId: workspaceId,
                req: .init(
                    status: status,
                    nick: nick,
                    spot: spot,
                    belong: belong,
                    phone: phone,
                    wire: wire,
                    location: location
                )
            )
        )
    }
}
