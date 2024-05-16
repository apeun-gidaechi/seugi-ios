import Foundation
import DIContainerInterface
import AuthDomainInterface

public final class EmailVerificationViewModel: ObservableObject {
    
    // MARK: - UseCase
    @Inject private var sendEmailCodeUseCase: any SendEmailCodeUseCase
    @Inject private var signUpUseCase: any SignUpUseCase
    
    // MARK: - State
    @Published var verificationCode = ""
    public var name = ""
    public var email = ""
    public var password = ""
    @Published var isWaiting = false
    
    var isInValidInput: Bool {
        verificationCode.count < 6
    }
    
    @MainActor
    func sendEmail() async {
        do {
            try await sendEmailCodeUseCase(email: email)
            isWaiting = true
        } catch {
            
        }
    }
    
    @MainActor
    func signUp() async {
        do {
            let request = SignUpRequest(name: name, email: email, password: password, token: verificationCode)
            try await signUpUseCase(request)
        } catch {
            
        }
    }
}
