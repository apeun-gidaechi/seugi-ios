import Domain

extension Token: Mock {
    public static func mock() -> Token {
        Token(
            accessToken: "accessToken",
            refreshToken: "refreshToken"
        )
    }
}
