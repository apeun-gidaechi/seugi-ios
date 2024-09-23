import Foundation
import Domain
import DIContainer

public final class StartViewModel: BaseViewModel<StartViewModel.Effect> {
    
    public enum Effect {
        case signInSuccess(token: Token)
    }
    
    // MARK: - Repo
    @Inject private var oauthRepo: OAuthRepo
    
    // MARK: - State
    @Published var signInFlow: IdleFlow<Token> = .idle
    
    // MARK: - Method
    func signIn(token: String, provider: OAuth2Provider) {
        switch provider {
        case .google:
            oauthRepo.authenticateGoogle(
                .init(code: token)
            ).fetching {
                self.signInFlow = .fetching
            }.success { res in
                self.signInFlow = .success(res.data)
            }.failure { err in
                self.signInFlow = .failure(err)
            }.observe(&subscriptions)
        case .apple:
            break
        }
    }
}
