import Foundation
import GoogleSignIn

enum GoogleLoginError: Error {
    case notFoundRootViewController
}

final class GoogleLoginViewModel: ObservableObject {
    @Published var loginFlow: Flow<GIDSignInResult> = .idle
}

extension GoogleLoginViewModel {
    @MainActor
    func signIn() {
        Task {
            do {
                guard let rootViewController = UIApplication.shared.rootController else {
                    print("GoogleLoginViewModel.signIn - rootViewController is nil")
                    loginFlow = .failure(GoogleLoginError.notFoundRootViewController)
                    return
                }
                let result = try await GIDSignIn.sharedInstance.signIn(
                    withPresenting: rootViewController,
                    hint: nil,
                    additionalScopes: []
                )
                loginFlow = .success(result)
            } catch {
                loginFlow = .failure(error)
            }
        }
    }
}
