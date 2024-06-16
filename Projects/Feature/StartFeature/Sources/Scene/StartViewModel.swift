import Foundation
import Domain
import DIContainer
import BaseFeatureInterface

public final class StartViewModel: BaseViewModel<StartViewModel.StartSubject> {
    
    public enum StartSubject {
        case signInSuccess(token: Token)
    }
    
    // MARK: - Repo
    @Inject private var memberRepo: MemberRepo
    
    // MARK: - State
    @Published var signInFlow: IdleFlow<Bool> = .fetching
    @Published var isSignInFailure = false
    
    // MARK: - Method
    func signIn(token: String, provider: OAuth2Provider) {
        sub(memberRepo.oauth2(code: token, provider: provider)) {
            self.signInFlow = .fetching
        } success: { [self] token in
            signInFlow = .success()
            emit(.signInSuccess(token: token.data))
        } failure: { error in
            self.signInFlow = .failure(error)
            self.isSignInFailure = true
        }
    }
}
