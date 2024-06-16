import PublicInit

@PublicInit
public struct Token: Entity {
    public let accessToken: String
    public let refreshToken: String
}
