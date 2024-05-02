import Foundation
import AuthDomainInterface
import DIContainerInterface
import BaseFeatureInterface

public final class StartViewModel: ObservableObject {
    
    @Inject private var oauthSignInUseCase: any OAuthSignInUseCase
    @Published var signInWithGoogleFlow: FetchFlow<Token> = .Fetching
    
    public init() {}
    
    @MainActor
    func signInWithGoogle(
        idToken: String
    ) async {
        do {
            let token = try await oauthSignInUseCase(.init(code: idToken, registrationId: "google"))
            signInWithGoogleFlow = .Success(data: token)
        } catch {
            signInWithGoogleFlow = .Failure
        }
    }
}
