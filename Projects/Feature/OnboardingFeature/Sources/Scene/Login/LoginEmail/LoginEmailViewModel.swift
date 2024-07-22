import Foundation
import Domain
import DIContainer
import BaseFeatureInterface
import Combine
import SwiftUI

public class LoginEmailViewModel: BaseViewModel<LoginEmailViewModel.EmailSignInSubject> {
    
    public enum EmailSignInSubject {
        case signInSuccess(token: Token)
    }
    
    // MARK: - Repo
    @Inject private var memberRepo: MemberRepo
    
    // MARK: - State
    @Published var email = ""
    @Published var password = ""
    @Published var isSignInFetching = false
    @Published var showSignInFailureDialog = false
    
    public override init() {
        super.init()
    }
    
    // MARK: - Method
    func signIn() {
        sub(memberRepo.login(email: email, password: password)) {
            self.isSignInFetching = true
        } success: { res in
            self.emit(.signInSuccess(token: res.data))
        } failure: { error in
            if case .http(let error) = error {
                print(error)
            }
            self.showSignInFailureDialog = true
        } finished: {
            self.isSignInFetching = false
        }
    }
}
