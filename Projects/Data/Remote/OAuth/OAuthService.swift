import Foundation
import Domain

final class OAuthService: OAuthRepo {
    let runner: NetRunner
    
    init(runner: NetRunner) {
        self.runner = runner
    }
    
    func authenticateGoogle(_ req: GoogleCodeReq) -> APIResult<Base<Token>> {
        runner.deepDive(OAuthEndpoint.authenticateGoogle(req), res: Base<Token>.self)
    }
    
    func connectGoogle(_ req: GoogleCodeReq) -> APIResult<BaseVoid> {
        runner.deepDive(OAuthEndpoint.connectGoogle(req), res: BaseVoid.self)
    }
    
    func authenticateApple(_ req: AppleCodeReq) -> APIResult<Base<Token>> {
        runner.deepDive(OAuthEndpoint.authenticateApple(req), res: Base<Token>.self)
    }
}
