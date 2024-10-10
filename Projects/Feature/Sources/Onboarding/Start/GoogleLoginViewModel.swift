import Foundation
import GoogleSignIn

enum GoogleLoginError: Error {
    case notFoundRootViewController
}

final class GoogleLoginViewModel: ObservableObject {
    @MainActor
    func signIn() async throws -> GIDSignInResult {
        guard let rootViewController = UIApplication.shared.rootController else {
            print("GoogleLoginViewModel.signIn - rootViewController is nil")
            throw GoogleLoginError.notFoundRootViewController
        }
        return try await GIDSignIn.sharedInstance.signIn(
            withPresenting: rootViewController,
            hint: nil,
            additionalScopes: []
        )
    }
}
