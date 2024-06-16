import Domain

struct TokenRes: Decodable, EntityMappable {
    let accessToken: String
    let refreshToken: String
    
    func toEntity() -> Token {
        Token(
            accessToken: accessToken,
            refreshToken: refreshToken
        )
    }
}
