import Foundation
import BaseFeatureInterface
import DIContainer
import Domain
import SwiftUI

public final class EmailVerificationViewModel: BaseViewModel<EmailVerificationViewModel.EmailVerificationSubject> {
    
    public enum EmailVerificationSubject {}
    
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
        } success: { res in
            print(res)
            self.sendEmailFlow = .success()
        } failure: { error in
            print(error)
            self.sendEmailFlow = .failure(error)
        }
    }
    
    func signUp() {
        sub(memberRepo.register(name: name, email: email, password: password, code: verificationCode)) {
            self.signUpFlow = .fetching
        } success: { _ in
            self.signUpFlow = .success()
        } failure: { error in
            print(error)
            self.signUpFlow = .failure(error)
        }
    }
}
