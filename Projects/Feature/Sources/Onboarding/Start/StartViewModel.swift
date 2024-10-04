import Foundation
import Domain
import DIContainer
import SwiftUtil

public final class StartViewModel: BaseViewModel<StartViewModel.Effect> {
    
    public enum Effect {
        case signInSuccess(token: Token)
    }
    
    // MARK: - Repo
    @Inject private var oauthRepo: OAuthRepo
    
    // MARK: - State
    @Published var signInFlow: Flow<Token> = .idle
    
    // MARK: - Method
    func signIn(code: String, provider: OAuth2Provider) {
        switch provider {
        case .google:
            oauthRepo.authenticateGoogle(
                .init(code: code)
            )
            .map(\.data)
            .flow(\.signInFlow, on: self)
            .silentSink()
            .store(in: &subscriptions)
        case .apple:
            break
        }
    }
}
