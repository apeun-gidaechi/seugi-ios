import AuthDomainInterface

struct TokenResponse: Decodable {
    let accessToken: String
    let refreshToken: String
}

extension TokenResponse {
    func toDomain() -> Token {
        Token(
            accessToken: accessToken,
            refreshToken: refreshToken
        )
    }
}
