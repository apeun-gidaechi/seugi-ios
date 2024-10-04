import Foundation
import DIContainer
import Domain
import SwiftUtil
import Combine

public final class RegisterEmailViewModel: ObservableObject {
    var subscriptions = Set<AnyCancellable>()
    
    // MARK: - Repo
    @Inject private var emailRepo: EmailRepo
    @Inject private var memberRepo: MemberRepo
    
    // MARK: - State
    @Published var name: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var passwordCheck: String = ""
    
    @Published var verificationCode: String = ""
    @Published var isWaiting: Bool = false
    @Published var sendEmailFlow: Flow<Bool> = .idle
    @Published var signUpFlow: Flow<Token> = .idle
    
    var isInValidInput: Bool {
        name.isEmpty || email.isEmpty || password.isEmpty || passwordCheck.isEmpty || password != passwordCheck
    }
    
    var isInValidCodeInput: Bool {
        verificationCode.count < 6
    }
    
    func sendEmail() {
        isWaiting = true
        emailRepo.send(email: email)
            .map { _ in true }
            .flow(\.sendEmailFlow, on: self)
            .silentSink()
            .store(in: &subscriptions)
    }
    
    func signUp() {
        memberRepo.register(
            .init(
                name: name, email: email, password: password, code: verificationCode
            )
        )
        .map(\.data)
        .flow(\.signUpFlow, on: self)
        .silentSink()
        .store(in: &subscriptions)
    }
}
