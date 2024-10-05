import Foundation

import Domain

final class OAuthService: Service<OAuthEndpoint>, OAuthRepo {
    func authenticateGoogle(_ req: GoogleCodeReq) -> APIResult<Base<Token>> {
        performRequest(.authenticateGoogle(req), res: Token.self)
    }
    
    func connectGoogle(_ req: GoogleCodeReq) -> APIResult<BaseVoid> {
        performRequest(.connectGoogle(req))
    }
}
