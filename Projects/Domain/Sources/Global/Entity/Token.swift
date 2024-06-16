import SwiftBok

@PublicInit
@PublicMembers
public struct Token: Entity {
    public let accessToken: String
    public let refreshToken: String
}
