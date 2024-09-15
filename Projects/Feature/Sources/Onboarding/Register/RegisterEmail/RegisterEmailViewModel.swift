import Component
import Foundation
import DIContainer
import Domain

public final class RegisterEmailViewModel: BaseViewModel<RegisterEmailViewModel.Effect> {
    
    public enum Effect {
        case registerSuccess(Token)
    }
    
    // MARK: - Repo
    @Inject private var emailRepo: EmailRepo
    @Inject private var memberRepo: MemberRepo
    
    // MARK: - State
    @Published var name = ""
    @Published var email = ""
    @Published var password = ""
    @Published var passwordCheck = ""
    
    @Published var verificationCode = ""
    @Published var isWaiting = false
    @Published var sendEmailFlow: IdleFlow<Bool> = .idle
    @Published var signUpFlow: IdleFlow<Bool> = .idle
    
    var isInValidInput: Bool {
        name.isEmpty || email.isEmpty || password.isEmpty || passwordCheck.isEmpty || password != passwordCheck
    }
    
    var isInValidCodeInput: Bool {
        verificationCode.count < 6
    }
    
    func sendEmail() {
        emailRepo.send(email: email).fetching { [self] in
            isWaiting = true
            sendEmailFlow = .fetching
        }.success { _ in
            self.sendEmailFlow = .success()
        }.failure { error in
            self.sendEmailFlow = .failure(error)
        }.observe(&subscriptions)
    }
    
    func signUp() {
        memberRepo.register(
            .init(
                name: name, email: email, password: password, code: verificationCode
            )
        ).fetching {
            self.signUpFlow = .fetching
        }.success { token in
            self.emit(.registerSuccess(token.data))
            self.signUpFlow = .success()
        }.failure { error in
            log(error)
            self.signUpFlow = .failure(error)
        }.observe(&subscriptions)
    }
}
