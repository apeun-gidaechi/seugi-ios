import BaseDomainInterface
import AuthDomainInterface

class OAuthDataSourceImpl: RemoteProtocol, OAuthDataSource {
    typealias Target = OAuthTarget
    func oauthSignIn(_ req: OAuthSignInRequest) async throws -> Token {
        try await request(target: .oauthSignIn(code: req.code, registrationId: req.registrationId), isAuthorization: true)
            .map(BaseResponse<TokenResponse>.self, using: decoder).data.toDomain()
    }
}
