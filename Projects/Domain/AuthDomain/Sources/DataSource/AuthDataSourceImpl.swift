import AuthDomainInterface
import BaseDomainInterface

class AuthDataSourceImpl: RemoteProtocol, AuthDataSource {
    typealias Target = AuthTarget
    
    func signIn(_ req: SignInRequest) async throws -> Token {
        try await request(target: .signIn(req), isAuthorization: true)
            .map(BaseResponse<TokenResponse>.self, using: decoder).data.toDomain()
    }
    
    func signUp(_ req: SignUpRequest) async throws {
        _ = try await request(target: .signUp(req), isAuthorization: true)
            .map(BaseVoidResponse.self, using: decoder)
    }
    
    func sendEmailCode(email: String) async throws {
        _ = try await request(target: .sendEmailCode(email: email), isAuthorization: true)
            .map(BaseVoidResponse.self, using: decoder)
    }
    
    func verifyEmailCode(code: String) async throws{
        _ = try await request(target: .verifyEmailCode(code: code), isAuthorization: true)
            .map(BaseVoidResponse.self, using: decoder)
    }
}
