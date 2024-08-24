import SwiftBok

@Init()
@Members()
public struct LoginMemberReq: Encodable {
    public let email: String
    public let password: String
}
