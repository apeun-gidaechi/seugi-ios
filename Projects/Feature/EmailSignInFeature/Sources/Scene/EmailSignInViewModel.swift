import Foundation
import AuthDomainInterface
import DIContainerInterface
import BaseFeatureInterface

public class EmailSignInViewModel: ObservableObject {
    
    // MARK: - UseCase
    @Inject private var signInUseCase: any SignInUseCase
    
    // MARK: - State
    @Published var email = ""
    @Published var password = ""
    @Published var isSignInFetching = false
    @Published var showSignInFailureDialog = false
    
    public init() {}
    
    func signIn(
        completion: @escaping (_ token: Token) async -> Void
    ) async {
        isSignInFetching = true
        defer { isSignInFetching = false }
        do {
            let request = SignInRequest(email: email, password: password)
            let token = try await signInUseCase(request)
            print(token)
            await completion(token)
        } catch {
            showSignInFailureDialog = true
        }
    }
}
