import Foundation
import AuthDomainInterface
import DIContainerInterface
import BaseFeatureInterface

public final class StartViewModel: ObservableObject {
    
    @Inject private var oauthSignInUseCase: any OAuthSignInUseCase
    @Published var signInFlow: FetchFlow<Token> = .Fetching
    @Published var showSignInFailureDialog = true
    
    public init() {}
    
    @MainActor
    func signInWithGoogle(
        idToken: String
    ) async {
        do {
            let token = try await oauthSignInUseCase(.init(code: idToken, registrationId: "google"))
            signInFlow = .Success(data: token)
        } catch {
            signInFlow = .Failure
            showSignInFailureDialog = true
        }
    }
    
    @MainActor
    func signInWithApple(
        token: String
    ) async {
        do {
            let token = try await oauthSignInUseCase(.init(code: token, registrationId: "apple"))
            signInFlow = .Success(data: token)
        } catch {
            signInFlow = .Failure
            showSignInFailureDialog = true
        }
    }
}
