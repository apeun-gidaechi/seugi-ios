import Foundation
import AuthenticationServices
import Then

enum AppleLoginError: Error {
    case notFoundCredential
    case notFoundIdToken
    case error(Error)
}

struct AppleLoginResult: Equatable {
    let code: String
    let nickname: String
}

final class AppleLoginViewModel: NSObject, ObservableObject {
    @Published var loginFlow: Flow<AppleLoginResult> = .idle
}

extension AppleLoginViewModel {
    func signIn() {
        let request = ASAuthorizationAppleIDProvider().createRequest().then {
            $0.requestedScopes = [.fullName, .email]
        }
//        request.nonce = encodeNonce
        
        ASAuthorizationController(authorizationRequests: [request]).do {
            $0.delegate = self
            $0.presentationContextProvider = self
            $0.performRequests()
        }
    }
}

extension AppleLoginViewModel: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        guard let credential = authorization.credential as? ASAuthorizationAppleIDCredential else {
            print("AppleSignInObservable - credential not found")
            self.loginFlow = .failure(AppleLoginError.notFoundCredential)
            return
        }
        guard let authorizationCode = credential.authorizationCode,
              let authorizationCodeString = String(data: authorizationCode, encoding: .utf8) else {
            print("AppleSignInObservable - identityToken not found")
            self.loginFlow = .failure(AppleLoginError.notFoundIdToken)
            return
        }
        
        let fullName = credential.fullName
        let nickname = (fullName?.familyName ?? "") + (fullName?.givenName ?? "")
        
        self.loginFlow = .success(
            .init(
                code: authorizationCodeString,
                nickname: nickname
            )
        )
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: any Error) {
        print("AppleSignInObservable - failure \(error)")
        self.loginFlow = .failure(AppleLoginError.error(error))
    }
}

extension AppleLoginViewModel: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        guard let window = UIApplication.shared.window else {
            fatalError("No window found")
        }
        return window
    }
}
