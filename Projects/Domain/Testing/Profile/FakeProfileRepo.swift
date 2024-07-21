import Domain

public final class FakeProfileRepo: ProfileRepo {
    public init() {}
    public func patchProfile(workspaceId: String, status: String, nick: String, spot: String, belong: String, phone: String, wire: String, location: String) -> APIResult<BaseVoid> {
        [].publisher.eraseToAnyPublisher()
    }
    
    public func me(workspaceId: String) -> Domain.APIResult<Domain.Base<Domain.RetrieveProfile>> {
        [].publisher.eraseToAnyPublisher()
    }
    
    public func others(workspaceId: String, memberId: String) -> Domain.APIResult<Domain.Base<Domain.RetrieveProfile>> {
        [].publisher.eraseToAnyPublisher()
    }
}
