import SwiftBok

@Init()
@Members()
public struct Token: Entity {
    public let accessToken: String
    public let refreshToken: String
}
