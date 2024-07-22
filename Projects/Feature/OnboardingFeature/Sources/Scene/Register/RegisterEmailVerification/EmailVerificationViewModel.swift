import Foundation
import BaseFeatureInterface
import DIContainer
import Domain
import SwiftUI

public final class RegisterEmailVerificationViewModel: BaseViewModel<RegisterEmailVerificationViewModel.EmailVerificationSubject> {
    
    public enum EmailVerificationSubject {
        case registerSuccess(Token)
    }
    
    // MARK: - Repo
    @Inject private var emailRepo: EmailRepo
    @Inject private var memberRepo: MemberRepo
    
    // MARK: - State
    @Published var verificationCode = ""
    @Published var isWaiting = false
    @Published var sendEmailFlow: IdleFlow<Bool> = .idle
    @Published var signUpFlow: IdleFlow<Bool> = .idle
    var isFetchSignUp: Bool { signUpFlow == .fetching }
    
    var name = ""
    var email = ""
    var password = ""
    
    var isInValidInput: Bool {
        verificationCode.count < 6
    }
    
    func sendEmail() {
        sub(emailRepo.send(email: email)) { [self] in
            isWaiting = true
            sendEmailFlow = .fetching
        } success: { _ in
            self.sendEmailFlow = .success()
        } failure: { error in
            self.sendEmailFlow = .failure(error)
        }
    }
    
    func signUp() {
        sub(memberRepo.register(name: name, email: email, password: password, code: verificationCode)) {
            self.signUpFlow = .fetching
        } success: { token in
            self.emit(.registerSuccess(token.data))
            self.signUpFlow = .success()
        } failure: { error in
            print(error)
            self.signUpFlow = .failure(error)
        }
    }
}
