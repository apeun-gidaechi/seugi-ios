import SwiftBok

@Init()
@Members()
public struct EditMemberReq: Encodable {
    public let picture: String
    public let name: String
    public let birth: String
}
