import Foundation
import Domain
import DIContainer
import BaseFeatureInterface

public final class StartViewModel: ObservableObject {
    
//    @Inject private var oauthSignInUseCase: any OAuthSignInUseCase
//    @Published var signInFlow: FetchFlow<Token> = .fetching
    @Published var showSignInFailureDialog = false
    
    public init() {}
    
    @MainActor
    func signInWithGoogle(
        idToken: String
    ) async {
        do {
//            let token = try await oauthSignInUseCase(.init(code: idToken, registrationId: "google"))
//            signInFlow = .success(token)
        } catch {
//            signInFlow = .failure
            showSignInFailureDialog = true
            print(error)
        }
    }
    
    @MainActor
    func signInWithApple(
        token: String
    ) async {
        do {
//            let token = try await oauthSignInUseCase(.init(code: token, registrationId: "apple"))
//            signInFlow = .success(token)
        } catch {
//            signInFlow = .failure
            showSignInFailureDialog = true
            print(error)
        }
    }
}
