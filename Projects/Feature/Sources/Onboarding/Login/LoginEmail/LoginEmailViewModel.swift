import Foundation
import Domain
import DIContainer
import Combine
import SwiftUI

public final class LoginEmailViewModel: BaseViewModel<LoginEmailViewModel.Effect> {
    
    public enum Effect {}
    
    // MARK: - Repo
    @Inject private var memberRepo: MemberRepo
    
    // MARK: - State
    @Published var email = ""
    @Published var password = ""
    @Published var signInFlow: IdleFlow<Token> = .idle
    
    public override init() {
        super.init()
    }
    
    // MARK: - Method
    func signIn() {
        memberRepo.login(
            .init(
                email: email,
                password: password
            )
        )
        .fetching {
            self.signInFlow = .fetching
        }.success { res in
            self.signInFlow = .success(res.data)
        }.failure { error in
            self.signInFlow = .failure(error)
        }.observe(&subscriptions)
    }
}
