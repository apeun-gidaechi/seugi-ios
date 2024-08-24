import SwiftBok

@Init()
@Members()
public struct OAuth2MemberReq: Encodable {
    public let email: String
    public let name: String
}
