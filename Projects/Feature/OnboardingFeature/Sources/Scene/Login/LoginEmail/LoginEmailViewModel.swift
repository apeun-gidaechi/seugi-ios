import Foundation
import Domain
import DIContainer
import BaseFeatureInterface
import Combine
import SwiftUI

public final class LoginEmailViewModel: BaseViewModel<LoginEmailViewModel.EmailSignInSubject> {
    
    public enum EmailSignInSubject {}
    
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
        sub(memberRepo.login(email: email, password: password)) {
            self.signInFlow = .fetching
        } success: { res in
            self.signInFlow = .success(res.data)
        } failure: { error in
            self.signInFlow = .failure(error)
        }
    }
}
