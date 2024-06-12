import Foundation
import BaseFeatureInterface
import DIContainerInterface
import AuthDomainInterface
import SwiftUI

public final class EmailVerificationViewModel: ObservableObject {
    
    // MARK: - UseCase
    @Inject private var sendEmailCodeUseCase: any SendEmailCodeUseCase
    @Inject private var signUpUseCase: any SignUpUseCase
    
    // MARK: - State
    @Published var verificationCode = ""
    @Published var isWaiting = false
    @Published var isSendEmailFailure = false
    
    // dialog
    @Published var signUpFlow: IdleFlow<Bool> = .idle
    
    public var name = ""
    public var email = ""
    public var password = ""
    
    var isInValidInput: Bool {
        verificationCode.count < 6
    }
    
    @MainActor
    func sendEmail() async {
        do {
            isWaiting = true
            try await sendEmailCodeUseCase(email: email)
        } catch {
            isSendEmailFailure = true
        }
    }
    
    @MainActor
    func signUp() async {
        do {
            let request = SignUpRequest(name: name, email: email, password: password, code: verificationCode)
            try await signUpUseCase(request)
            signUpFlow = .success(true)
        } catch {
            signUpFlow = .failure
        }
    }
}
