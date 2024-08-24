import SwiftBok

@Init()
@Members()
public struct RegisterMemberReq: Encodable {
    public let name: String
    public let email: String
    public let password: String
    public let code: String
}
